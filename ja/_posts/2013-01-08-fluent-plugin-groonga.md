---
layout: post.ja
title: fluent-plugin-groongaについて
description:
groongaデータベースのレプリケーションを行うfluent-plugin-groongaについて説明します。
---
去年最後の肉の日である12/29に、ログ収集ツール
[fluentd](http://fluentd.org/)
を使って、groongaデータベースのレプリケーションを行うライブラリfluent-plugin-groonga
1.0.1をリリースしました。
しかし、blogroongaでは今までこのfluent-plugin-groongaについて説明していませんでした。
そこで、この記事ではfluent-plugin-groongaについて説明します。

fluent-plugin-groongaとは
-------------------------

fluent-plugin-groongaはfluentdのプラグイン集で、Rubyで実装されています。
通常、fluentdはログの収集に使いますが、fluent-plugin-groongaではgroongaのクエリを複数のgroongaサーバーに転送するために使っています。つまり、fluentdのメッセージルーティング機能だけを使ってレプリケーションに対応したgroongaシステムを構築します。

通常、groongaサーバーにアクセスするときは、groongaクライアントもしくはHTTPクライアントとgroongaサーバー同士が1対1で通信します。
fluent-plugin-groongaは、このクライアントとgroongaサーバーの間に入り、クライアントからのクエリーを複数のgroongaサーバーに送信することができます。groongaサーバーだけでなく、他のfluentdに送信することもできます。この機能を使ってレプリケーションを実装することができます。

レプリケーション実装のために、fluent-plugin-groongaは同じgroongaという名前でinputプラグインとoutputプラグインという2つのプラグインを提供しています。それでは、それぞれのプラグインについて説明します。

### inputプラグイン

inputプラグインは、本来groongaサーバーに送られるgroongaコマンドを受け取ります。groongaコマンドを受け取ったinputプラグインは、受け取ったgroongaのコマンドを0個以上のfluentdを経由し、後述するoutputプラグインに送ります。0個の場合は直接outputプラグインに送ります。
inputプラグインは、groongaコマンドを受け取るときのインターフェイスとしてHTTPとgroonga独自プロトコルである
[GQTP](/ja/docs/spec/gqtp.html)
の2つを提供します。つまり、inputプラグインにはgroongaサーバーと互換性のあるインターフェイスを用いてgroongaコマンドを送信することができます。このように、互換性のあるインタフェースを提供することで、inputプラグインをgroongaサーバーと同じように使うことができます。

### outputプラグイン

outputプラグインは受け取ったgroongaコマンドをgroongaサーバーに送ります。outputプラグインはHTTP、GQTP、コマンドとすべてのインターフェイスをサポートしています。inputプラグインで受け取ったgroongaコマンドのインタフェースに合わせる必要はありません。また、このとき送信するデータは
[copy output plugin](http://docs.fluentd.org/articles/out_copy)
（英語）で複製することもできます。

インストール
------------

Rubyのgemとしてfluent-plugin-groongaを提供しています。
そのため、インストールは次のコマンドを実行するだけで完了します。

    % gem install fluent-plugin-groonga

また、fluent-plugin-groongaもgroongaや関連プロダクトと同じく、
[GitHubにてソースコードが公開](https://github.com/groonga/fluent-plugin-groonga/)
されています。

ドキュメント
------------

[fluent-plugin-groongaのドキュメント](http://groonga.org/fluent-plugin-groonga/ja/)
には、
[具体的なレプリケーションの構成の仕方](http://groonga.org/fluent-plugin-groonga/ja/file.constitution.html)
や
[設定の仕方](http://groonga.org/fluent-plugin-groonga/ja/file.configuration.html)
が掲載されています。（なお、すべて日本語で書かれています。）
このドキュメントを参考に実際にレプリケーションを試してみてください！
なお、問題の報告や必要な機能の提案については、groongaのメーリングリスト
[groonga-dev](http://lists.sourceforge.jp/mailman/listinfo/groonga-dev)
やGitHubでのpull
requestで受け付けています。何かありましたらこちらもご活用ください！
