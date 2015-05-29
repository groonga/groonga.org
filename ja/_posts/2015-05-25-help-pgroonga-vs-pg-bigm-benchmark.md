---
layout: post.ja
title: 協力者募集：PGroongaとpg_bigmのベンチマークを実行
description: 協力者募集：PGroongaとpg_bigmのベンチマークを実行してくれる人を募集しています。
---

## 協力者募集：PGroongaとpg_bigmのベンチマークを実行

PostgreSQLで高速な日本語全文検索を実現するためにはどちらかの拡張機能を使う必要があります。

  * [PGroonga](https://github.com/pgroonga/pgroonga): Groongaを使った拡張機能
  * [pg_bigm](http://pgbigm.osdn.jp/): PostgreSQL組み込みのGINを使った拡張機能

それぞれ特性が違うため、ユーザーは用途に応じて適切な方を選択することになります。ユーザーが選択するときに使える材料として、性能特性を示すベンチマーク結果を準備しています。

実行時間に半日くらいかかるのですが、スクリプトを実行するだけですべてのベンチマークを実行できるようにしました。インストール直後の状態の64bit版CentOS 6を用意できる人は、スクリプトを実行してその結果をフィードバックしてもらえないでしょうか？

スクリプトの実行方法と結果のフィードバック先は次のGitHub Issueです。

  * [PGroongaとpg_bigmのベンチマーク結果 · Issue #2 · groonga/wikipedia-search](https://github.com/groonga/wikipedia-search/issues/2)

すでに2つ実行した結果があり、その結果をまとめたものが[PGroongaとpg_bigmのベンチマーク結果のサマリーを作る · Issue #3 · groonga/wikipedia-search](https://github.com/groonga/wikipedia-search/issues/3)にあります。フィードバックしてもらった結果も随時このIssueにまとめていく予定です。

PostgreSQLの日本語全文検索周りに興味のある方、Groongaを応援している方は、ぜひご協力お願いいたします！
