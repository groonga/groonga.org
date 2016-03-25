---
layout: post.ja
title: 静的構築した索引によるフレーズ検索の高速化
description: 索引を静的構築するときにチャンクを分割することで，頻出トークンとレアトークンの混ざったフレーズ検索を高速化できるようになりました．
published: false
---

## 静的構築した索引によるフレーズ検索の高速化

### 概要

静的に構築した索引を使ったフレーズ検索を高速化する方法を紹介します．データとクエリの組み合わせによっては 10 倍以上速くなるので，フレーズ検索が遅いと感じている方は試してみる価値があります．

実は，一年前（Groonga 5.0.1）に頻出トークンとレアトークンを同時に検索するときの高速化が取り入れられています．しかし，静的構築した索引では効果を得ることができませんでした．本記事で紹介するのは，高速化が有効になる索引を静的に構築する方法と，どのくらい効果があるのかです．

フレーズ検索の高速化については， groonga-dev における以下の投稿が参考になります．

- [https://osdn.jp/projects/groonga/lists/archive/dev/2014-December/003038.html]([groonga-dev,03095] 頻出トークンとレアトークンを一緒に検索したときの性能向上パッチ)

### 使い方

静的に索引を構築するとき，以下の環境変数が定義されていれば，高速化が有効になるように索引が構築されます．

```
GRN_INDEX_CHUNK_SPLIT_ENABLE=1
```

また，高速化を有効にするには，以下の環境変数が必要になります．

```
GRN_II_CURSOR_SET_MIN_ENABLE=1
```

使い方は以上です．

### 例

まずはデータを保存するためのテーブルを以下のコマンドで作成し， `page.body` に合計 2GiB, xxx,yyy レコードのデータを `load` しました．

```
$ groonga /tmp/groonga/db
> table_create page TABLE_NO_KEY
> column_create page body COLUMN_SCALAR Text
```

次に，以下のコマンドで静的に索引を構築しました．

```
$ groonga /tmp/groonga/db
> table_create idx_old TABLE_PAT_KEY ShortText --default_tokenizer TokenMecab --normalizer NormalizerAuto
> column_create idx_old body COLUMN_INDEX|WITH_POSITION page body

$ GRN_INDEX_CHUNK_SPLIT_ENABLE=1 groonga /tmp/groonga/db
> table_create idx_new TABLE_PAT_KEY ShortText --default_tokenizer TokenMecab --normalizer NormalizerAuto
> column_create idx_new body COLUMN_INDEX|WITH_POSITION page body
```

それから，いろいろなクエリについて検索時間を計測しました．計測に際しては，以下に示すコマンドの QUERY を入れ替えたものを使いました．

```
$ GRN_II_CURSOR_SET_MIN_ENABLE=1 groonga /tmp/groonga/db
> select page --match_columns idx_old.body --query 'QUERY' --limit 0 --cache no
> select page --match_columns idx_new.body --query 'QUERY' --limit 0 --cache no
```

以下の表には，各クエリについて 10 回の試行で得られたベストの検索時間を載せています．

|QUERY|idx_old|idx_new|補足|
|-----|------:|------:|----|
|    a|   0.0s|   0.0s|TBW|

以上のように，頻出トークンとレアトークンが混じったクエリについては劇的な改善が見込めます．
