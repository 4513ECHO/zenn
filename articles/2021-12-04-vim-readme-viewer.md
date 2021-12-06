---
title: "インストールしたプラグインのREADME.mdをお手軽に見れるvim-readme-viewer作った"
emoji: "📖"
type: "tech"
topics: ["vim", "neovim"]
published: false
---

## 作った動機

世界中のvimmerは、vimについて知りたいことがあればすぐにhelpを引くと思います。
なにしろ`:help {知りたいこと}`するだけです。
オンラインでも見れます。vimなら[ここ(日本語版)](https://vim-jp.org/vimdoc-ja/)、neovimなら[ここ(英語版)](https://neovim.io/doc/user/)です。
プラグインの設定もたいていはhelpを引きながらやれます。

しかし、中にはhelpがないプラグインも存在します。
特に新しめのneovimのプラグインや、colorscheme系のプラグインにはhelpが用意されていないことが多い印象です。
そんなときは、README.mdを見にいきます。helpがなくてもそれを見れば多くの場合解決します。
ですが、困ってしるときにいちいちGitHubを開くのは正直面倒です。そこで、こんなプラグインを作ってみました。

https://github.com/4513ECHO/vim-readme-viewer

## 使い方

詳しくは[Github](https://github.com/4513ECHO/vim-readme-viewer)を参考にしてください。
まずは使っているプラグインマネージャーを`g:readme_viewer#plugin_manager`に設定してください。
筆者は[dein.vim](https://github.com/Shougo/dein.vim)を使っているので、 下記のようにしました。

```vim
let g:readme_viewer#plugin_manager = 'dein.vim'
```

これによって使用できるコマンドが決まります。現在、指定可能な(サポートしている)プラグインマネージャーと、それぞれのコマンドは以下の通りです。

|                                                        |               |
|--------------------------------------------------------|---------------|
|[dein.vim](https://github.com/Shougo/dein.vim)          |`:DeinReadme`  |
|[vim-plug](https://github.com/junegunn/vim-plug)        |`:PlugReadme`  |
|[minpac](https://github.com/k-takata/minpac)            |`:PackReadme`  |
|[packer.nvim](https://github.com/wbthomason/packer.nvim)|`:PackerReadme`|

vimを起動し、おもむろに`:DeinReadme vim-readme-viewer`と実行します。

![doing :DeinReadme]()

これで簡単にREADME.mdが見れました🎉

ちなみに、ここからさらに`:ReadmeDir`と実行すると、プラグインがインストールされているディレクトリを表示します。
これはプラグインの内部構造を知りたいときに、なんらかのファイラー系プラグインを使っていると便利です。

また、`:ReadmeHelp`と実行すると、そのプラグインのhelpを表示します。helpが存在しないと失敗します。

## 最後に

全てのvimmerはhelpを読もう。
全てのプラグイン開発者はhelpを書こう。

