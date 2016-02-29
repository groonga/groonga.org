---
layout: post.ja
title: grafana-datasource-plugin-groonga 0.1.0リリース
description: grafana-datasource-plugin-groonga 0.1.0をリリースしました！
---

## grafana-datasource-plugin-groonga 0.1.0リリース

今日は4年に一度のうるう肉の日ですね！

[grafana-datasource-plugin-groonga](https://github.com/groonga/grafana-datasource-plugin-groonga)の最初のバージョンである0.1.0をリリースしました。

grafana-datasource-plugin-groongaは、[Grafana](http://grafana.org/)にGroongaのデータソースを追加するプラグインです。これを使うことで、Groongaのデータを簡単に可視化（グラフ化）することができます。

### できること

* Time型のカラムを含むテーブルの数値型カラムのデータをグラフ化する
  * GroongaにはHTTP経由でアクセスする
  * データを時系列で表示するため、Time型が必須
  * 数値型以外は統計情報ではないので対象外

現在は上記の機能しかありません。ユースケースとしては、一定時間ごとのログ情報が記録されたテーブルの特定カラムの推移を可視化するなどです。

### まだできないこと

* 複数カラムを一つのグラフに描画
* ドリルダウン結果をグラフ化

上記は今後のリリースで対応していく予定です。

### インストール方法

grafana-datasource-plugin-groongaのGitリポジトリーまたはアーカイブをGrafana本体のプラグインディレクトリーにコピーし、Grafanaサーバーを再起動します。詳細は[README](https://github.com/groonga/grafana-datasource-plugin-groonga#installation)をご覧ください。

### 使い方

まず、Grafanaの管理画面から以下のようにデータソースを追加します。以下は`http://localhost:10041`で動いているGroongaサーバーを指定する場合です。

![grafana-datasource-plugin-groonga-edit-datasource](https://cloud.githubusercontent.com/assets/386687/13377966/27033252-de36-11e5-91a5-14597b34a2c5.png)

次に、ダッシュボードからグラフを追加して、メトリクスを以下のように設定します。以下はTime型のカラムを持つDataテーブルの数値型のvalueカラムをグラフ化する例です。

![grafana-plugin-datasource-groonga-screenshot](https://cloud.githubusercontent.com/assets/386687/13373741/41058f8e-ddb3-11e5-83fd-d904f810f8fe.png)

詳細は[README](https://github.com/groonga/grafana-datasource-plugin-groonga#usage)をご覧ください。

### フィードバックのおねがい

今後は、複数カラムのデータを同時に表示したり、ドリルダウン結果を表示したりといった機能を追加していく予定です。が、どの機能にどの程度ニーズがあるのかよくわかっていません。そこで、こういうデータをこうやって可視化したいという希望があれば教えてもらえますか？ニーズがありそうな機能を優先して追加していきたいと思っています。連絡先は[GitHub Issues](https://github.com/groonga/grafana-datasource-plugin-groonga/issues)やREADMEの[コミュニティ](https://github.com/groonga/grafana-datasource-plugin-groonga#community)から好きな方法を選んでください。Grafanaの使い方などの質問も歓迎します。

### まとめ

[grafana-datasource-plugin-groonga](https://github.com/groonga/grafana-datasource-plugin-groonga)の最初のリリースを紹介しました。

Groongaのデータの可視化に興味がある方は、使ってみてフィードバックをください。よろしくお願いします。
