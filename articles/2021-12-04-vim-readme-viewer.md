---
title: "インストールしたプラグインのREADME.mdをお手軽に見れるvim-readme-viewer作った"
emoji: "📖"
type: "tech"
topics: ["vim", "neovim"]
published: true
---

:::message
この記事は[Vim Advent Calendar 2021](https://qiita.com/advent-calendar/2021/vim)カレンダー2の7日目の記事です。
:::

## 作った動機

世界中のvimmerは、vimについて知りたいことがあればすぐにhelpを引くと思います。
何しろ`:help {知りたいこと}`するだけです。
オンラインでも見ることができます。vimなら[ここ(日本語版)](https://vim-jp.org/vimdoc-ja/)、neovimなら[ここ(英語版)](https://neovim.io/doc/user/)です。
プラグインの設定もたいていはhelpを引きながらやれます。

便利にhelpを引くためのTipsもいろいろな人が書いています。
 - [Vimのhelpを快適に引こう - haya14busa](http://haya14busa.com/reading-vim-help/)
 - [Vim :helpがユニークな3つのポイント、vim :helpを読むための敷居を下げる3つの事柄 - Qiita](https://qiita.com/shinshin86/items/eb41e4fb513bb4d3e3cd)

しかし、中にはhelpがないプラグインも存在します。
特に新しめのneovimのプラグインや、colorscheme系のプラグインにはhelpが用意されていないことが多い印象です。
そんなときは、README.mdを見にいきます。helpがなくてもそれを見れば多くの場合解決します。
ですが、困っているときにいちいちGitHubを開くのは正直面倒です。そこで、こんなプラグインを作ってみました。

@[card](https://github.com/4513ECHO/vim-readme-viewer)

## 使い方

詳しくは[GitHub](https://github.com/4513ECHO/vim-readme-viewer)を参考にしてください。
まずは使っているプラグインマネージャーを`g:readme_viewer#plugin_manager`に設定してください。
筆者は[dein.vim](https://github.com/Shougo/dein.vim)を使っているので、 下記のようにしました。

```vim
let g:readme_viewer#plugin_manager = 'dein.vim'
```

これによって使用できるコマンドが決まります。現在、指定可能な（サポートしている）プラグインマネージャーと、それぞれのコマンドは以下の通りです。

|                                                        |               |
|--------------------------------------------------------|---------------|
|[dein.vim](https://github.com/Shougo/dein.vim)          |`:DeinReadme`  |
|[vim-plug](https://github.com/junegunn/vim-plug)        |`:PlugReadme`  |
|[minpac](https://github.com/k-takata/minpac)            |`:PackReadme`  |
|[packer.nvim](https://github.com/wbthomason/packer.nvim)|`:PackerReadme`|

vimを起動し、おもむろに`:DeinReadme vim-readme-viewer`と実行します。

![doing :DeinReadme](/images/vim-readme-viewer-1.gif)

これで簡単にREADME.mdを見ることができました🎉

ちなみに、ここからさらに`:ReadmeDir`と実行すると、プラグインがインストールされているディレクトリを表示します。
これは`:e %:p:h`をしているだけですが、プラグインの内部構造を知りたいときに、何らかのファイラ系プラグインを使っていると便利です。
筆者は[vim-molder](https://github.com/mattn/vim-molder)というファイラプラグインを使っていて、この動作を`<Space>f`で行うようにしています。
個人的に使っているプラグインの中を見たくなる機会は多いので、実際のところREADME.mdを見るより重宝しています。

また、`:ReadmeHelp`と実行すると、そのプラグインのhelpを表示します。helpが存在しないと失敗します。

## 実装と問題点

vim-readme-viewerはデフォルトで`:help`と同じようにウィンドウを開く、つまりもともと開いているヘルプウィンドウを上書きするように開きます。
これは`:helpclose`を事前に行うことで再現しています。
また、ユーザーが定義したExコマンドの内部で`:execute`を使っている場合、`:vertical`や`:topleft`などの後に続くコマンドの動作を変更するコマンド[^1]は動作しません。
`v:count`などど同じように`v:vertical`のような変数があればよいのですが…

## 最後に

今は上記の4つのプラグインマネージャーにのみ対応していますが、GitHubでStarが100以上あるものは将来的にサポートする予定です。
それにしても[vim-pathogen](https://github.com/tpope/vim-pathogen)とか[Vundle.vim](https://github.com/VundleVim/Vundle.vim)とかもはや使っている人いるんでしょうかね。
[NeoBundle](https://github.com/Shougo/neobundle.vim)は公式にdeprecatedになったのでサポートしません。
コマンドの追加など、Pull-Requestも気軽にお待ちしています。

自分の作ったこのプラグインが多くの人に使ってもらえることはうれしいことです。しかし、それは世の中にhelpが書かれていないプラグインがあるということです。

**「すべてのvimmerはhelpを読もう。
すべてのプラグイン開発者はhelpを書こう。」**

結局はこれが一番大事です。


[^1]: `:help :vertical`からのセクションに完全なリストがあります
