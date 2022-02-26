---
title: "zshのautoloadで存在を調べる"
emoji: "🐚"
type: "tech"
topics: ["zsh", "shell"]
publishAt: "2022-02-27"
published: false
---

zshでautoloadの存在判定でつまずいたのでメモです。
しくみの問題上、autoloadは必ず成功（=終了ステータスが0）します。
どれだけtypoしてようが成功します。
ですから、

```sh
autoload hoge || export NO_HOGE=true
```

のようにして関数の存在を判定することはできません。
`||`は前のコマンドの終了ステータスが0以外のときに後のコマンドを実行するからです。

```sh
if type hoge > /dev/null; then
  export NO_HOGE=true
fi
```

同様に、上の方法でも判定はできません。
この理由は、実際に`which hoge`を実行してみるとわかります。
zshでは`which`コマンドを関数に対して実行するとその中身を表示できます。
結果がこちらです。

```sh
hoge () {
        # undefined
        builtin autoload -X
}
```

autoloadで読み込んだ関数は、最初に上のようにのみ定義されます。
実行したときにまで評価が遅延されるので、単純に関数の存在を調べるだけではだめなのです。

## 解決策

遅延されるなら実際に実行してみれば良いんです。

```sh
if hoge > /dev/null 2>&1; then
  : # do something
fi
```

終了ステータスさえあれば良いので、出力はすべて捨てています。
副作用のある関数を考慮しなければ、たいていはこれで解決できます。
