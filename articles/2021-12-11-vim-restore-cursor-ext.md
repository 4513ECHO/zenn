---
title: "vimでファイルを開いたときにカーソルを戻す+α"
emoji: "🥌"
type: "tech"
topics: ["vim", "neovim"]
published: true
---

:::message
この記事は[Vim Advent Calendar 2021](https://qiita.com/advent-calendar/2021/vim)カレンダー2の20日目の記事です。
:::

## 初めに

vim helpの`restore-cursor`に書いてあるTips ([リンク](https://vim-jp.org/vimdoc-ja/usr_05.html#restore-cursor)) は、さまざまな記事で紹介されているため、設定している人も多いと思われます。
これを設定すると、ファイルを開いたときに自動でカーソルが前回あった位置に移動します。

```vim
autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$")
      \ |   exe "normal! g`\""
      \ | endif
```
今回はこれをさらに便利にして、カーソルを画面の真ん中に持ってくるようにしました。

## やり方

```vim
augroup restore-cursor
  autocmd!
  autocmd BufReadPost *
        \ : if line("'\"") >= 1 && line("'\"") <= line("$")
        \ |   exe "normal! g`\""
        \ | endif
  autocmd BufWinEnter *
        \ : if empty(&buftype) && line('.') > winheight(0) / 2
        \ |   execute 'normal! zz'
        \ | endif
augroup END
```

`:augroup`コマンドでautocommandの再読み込みを防いでいます。
カーソルの位置が画面の半分より下にあったら、`normal! zz`でカーソルを画面の真ん中に持ってきています。
`BufWinEnter`はバッファ（ファイルの中身）がウィンドウ内に表示された後のタイミングで発生するautocommandです。

筆者はカーソルを画面の真ん中ではなく、上から3分の2の位置におくような設定をしています。

```vim
augroup restore-cursor
  autocmd!
  autocmd BufReadPost *
        \ : if line("'\"") >= 1 && line("'\"") <= line("$")
        \ |   exe "normal! g`\""
        \ | endif
  autocmd BufWinEnter *
        \ : if empty(&buftype) && line('.') > winheight(0) / 3 * 2
        \ |   execute 'normal! zz' .. repeat("\<C-y>", winheight(0) / 6)
        \ | endif
augroup END
```

欠点として、`<C-^>`で代替ファイル間を移動したときには`BufWinEnter`は発生しません。
`nnoremap <C-^> <C-^><Cmd>edit<CR>`のようにして再読み込みをすれば良いです。

## 最後に

編集を始めたときにカーソルが見やすい位置にあると、とても便利です。
皆さんもぜひ使ってみてください。

