---
layout: post.ja
title: 第7回フクオカRuby大賞で特別賞を受賞
description: 第7回フクオカRuby大賞で特別賞を受賞しました！
---

## 第7回フクオカRuby大賞で特別賞を受賞

福岡県Ruby・コンテンツビジネス振興会議と福岡県が主催している「Rubyの特徴を活かして開発したシステムや新しいビジネスモデル、普及に関する取組」を評価して賞を与える[第7回フクオカRuby大賞](http://www.digitalfukuoka.jp/events/45)というイベントがありました。Groongaはクエリーオプティマイザーやプラグイン開発API用にmrubyを組み込めるようになっているので、Groongaにmrubyを組み込んだ事例を「Rubyの特徴を活かして開発したシステム」として応募していました。

先日、[第7回フクオカRuby大賞の結果が発表](http://www.digitalfukuoka.jp/topics/68)されました。このGroongaの取り組みは特別賞を受賞しました。ありがとうございます。

![第7回フクオカRuby大賞の特別賞の賞状](/images/fukuoka-ruby-award-7-groonga-mruby.jpeg)

（[応募に使った資料はGitHub上にある](https://github.com/kou/rabbit-slide-kou-fukuoka-ruby-award-7)ので、来年度以降のフクオカRuby大賞に応募したい人は参考に使えるかもしれません。）

さて、そんなGroongaのmruby組み込みですが、近いうちにデフォルトで有効にする予定です。（現在はデフォルト無効で、ビルド時に明示的に有効にしなければいけません。）

理由は、mruby化によるパフォーマンス低下が軽微であること（Cで書いたコードよりmrubyで書いたコードの方が遅くなります）、mruby実装のクエリーオプティマイザーのみに実装している最適化が効くケースではパフォーマンスが向上すること、開発者が普段から使っていて安定してきたと感じること、あたりです。もちろん、テストしてくれる人が増えるほど問題が見つかりやすくなるので、Groongaの開発に協力してくれる方は、mruby組み込み版のGroongaを試して結果（問題がなくても教えて欲しいです！）を教えてくれると助かります。

なお、すでにCMakeビルド時にもmruby組み込みビルドできるようになっており、configureを使ってビルドするシステムはもちろん、Windows用Mroonga（CMakeとVisual Studioでビルドする）でもmrubyを組み込めるようになっています。

mrubyでプラグインを書く仕組みもできています。mrubyで全文検索エンジンを拡張したい方はGroongaを試してみてください。
