---
title: ズンドコキヨシ with deno
emoji: "\U0001F995"
type: idea
topics:
  - deno
  - ズンドコキヨシ
published: true
---

https://twitter.com/kumiromilk/status/707437861881180160

https://qiita.com/shunsugai@github/items/971a15461de29563bf90

もはや太古のネタですが、denoでやっている人がいなかったのでやりました。後悔はしていません。

https://github.com/4513echo/deno-zundoko

GitHubで公開しているので、下のコマンドで簡単に動かせます。

```sh
deno run https://github.com/4513ECHO/deno-zundoko/raw/main/zundoko.ts
```

# 解説

```typescript
import {
  distinct,
  sample,
} from "https://deno.land/std@0.123.0/collections/mod.ts";
import { equal } from "https://deno.land/std@0.123.0/testing/asserts.ts";

function general_kiyoshi(phrases: string[], last_phrase: string): void {
  const stack: string[] = [];
  while (true) {
    const picked = sample(distinct(phrases));
    if (picked) {
      console.log(picked);
      stack.push(picked);
    }
    if (equal(stack.slice(-phrases.length), phrases)) {
      console.log(last_phrase);
      break;
    }
  }
}

if (equal(Deno.args, [])) {
  const zundoko = ["ズン", "ズン", "ズン", "ズン", "ドコ"];
  const kiyoshi = "キ・ヨ・シ！";
  general_kiyoshi(zundoko, kiyoshi);
} else {
  general_kiyoshi(Deno.args.slice(0, -1), Deno.args.slice(-1)[0]);
}
```

せっかくdenoを使っているので、[std](https://deno.land/std)縛りで書きます。
標準で豊富な資産があるのはdenoのよいところですよね。
今回は`collections`モジュールと`asserts`モジュールを使いました。
`general_kiyoshi`関数は`phrases`に単語のリスト、`last_phrase`に最終的な単語を取ります。
スタックに出力した文字を入れていって、末尾の要素を毎回比較するような単純なしくみです。

```typescript
    const picked = sample(distinct(phrases));
```

ここで`phrases`の中から要素を1つ選んでいます。Pythonでいえば`random.choice()`です。

```typescript
    if (equal(stack.slice(-phrases.length), phrases)) {
```

JavaScriptは`[] === []`が`false`になる~~クソ~~仕様を持っています。
しかし、`equal`関数を使えば正しく判定できます。

