---
layout: post.ja
title: groongaからGroongaへ - ドキュメントの表記を一緒に更新しませんか?
description: ドキュメントの表記を一緒に更新しませんか?
---

groongaからGroongaへ - ドキュメントの表記を一緒に更新しませんか?
----------------------------------------------------------------

リリースアナウンスや、公式ドキュメントをみてもうすでに気づいた人がいるかもしれませんが、Groonga関連のソフトウェアの表記を「Groonga」（先頭が大文字）へ統一する作業をすすめています。

それなりに分量があるので、ドキュメントに散らばっている「groonga」表記の統一をお手伝いしてくれる人を募集します。
詳細は後述する「協力者募集」を参照してください。コードを書かなくてもできることです。

### 表記の統一について

これまでは、日本語の文の中や英語の文の途中では「groonga」（先頭も小文字）という表記で、英語の文の先頭では「Groonga」（先頭が大文字）という表記を使ったりしていました。これからは、日本語のときでも「Groonga」（先頭が大文字）を使うようにします。

### 表記の統一の理由について

先頭を大文字に統一する理由は世界中で広く使われるようにしたいからです。

-   英語での表記 -
    テキストで大文字始まりだと固有名詞として認識してもらいやすい
-   日本語での表記 - 英語との統一性を重視して大文字に揃える

海外の人と英語でやりとりをすると、こちらは「groonga」（先頭小文字）で書いても「Groonga」（先頭大文字）で返ってくることが何度もありました。（あったと森さんから聞いています。）このことから、英語圏の人にとってはソフトウェアの名前は先頭大文字が普通なんだろうと感じるようになりました。Groonga関連の
ソフトウェアは海外でも広く使われるようにしたいので、より海外でなじみやすい表記に統一することにしました。

### ロゴへの影響について

ロゴについては見栄えを重視しているので「groonga」（先頭も小文字）のままです。
したがってこれまで通り変更はありません。

次のように、テキストとロゴで表記が違う例というのはそれなりにあるためです。

-   [Ubuntu](http://www.ubuntu.com/) （ロゴは小文字）
-   [Debian](http://www.debian.or.jp/) （ロゴは大文字）
-   [Red Hat](http://jp.redhat.com/) （ロゴはスペースなしの小文字）

### 協力者募集

具体的にどんなことをやればいいのかを説明します。基本的にはドキュメントのソースファイルごとにごとにpull
requestを送ってもらうと進めやすいです。

対象となるファイルはdoc/sourceディレクトリ以下の拡張子が「.txt」となっているファイルです。

あまりGitHubでの作業に慣れていなくてもできるように、「最初にやること」と「作業ごとにやること」、「ファイルごとにやること」に分けて順に説明します。

-   最初にやること
-   作業ごとにやること
-   ファイルごとにやること

#### 最初にやること

以下では、最初に一度だけ実施しておけば良いことを説明します。

##### 最初の設定

まずは、gitの設定をしましょう。すでにある程度gitを使っている場合には初期設定はすでに完了しているかも知れません。その場合には飛ばして構いません。

    % git config --global user.name "あなたのユーザー名"
    % git config --global user.email "あなたのメールアドレス"

上記はコミットログに使われます。公開しても差し支えないユーザ名もしくはメールアドレスを設定します。

##### GitHubでforkする

GitHubにアカウントがなければ用意してください。アカウントが用意できたら、ログインした状態で以下のURLにアクセスします。

-   [Groongaリポジトリをforkする](https://github.com/groonga/groonga/fork)

リポジトリ選択画面でご自分のリポジトリへとforkしてください。

##### 作業用リポジトリの初期設定

次は作業用にforkしたリポジトリを手元にcloneします。このとき、本家の変更に追従するための設定を行います。

    % git clone git@github.com:(あなたのGitHubのアカウント)/groonga.git
    % cd groonga
    % git remote add upstream git@github.com:groonga/groonga

##### ドキュメントビルド用の初期設定

ドキュメントを生成するために以下を実行します。

    % ./autogen.sh
    % ./configure --enable-document

ここまでで、「最初にやること」は完了です。次は「作業ごとにやること」へと進みます。

#### 作業ごとにやること

以下では作業ごとにやることを説明します。

##### Groonga本家に追従する

Groonga本家の最新状態に追従して、作業がかぶらないようにします。

    % git fetch --all
    % git checkout master
    % git rebase upstream/master

最新の状態に追従できたら、「ファイルごとにやること」へと進みます。

#### ファイルごとにやること

以下では、例えば http://groonga.org/docs/install/windows.html
を更新する場合で説明します。作業対象となるファイルは、リポジトリのdoc/source/ディレクトリ以下にあります。
今回は、doc/source/install/windows.txtを変更する例で説明します。

もうすでに統一作業が完了しているファイルについてはファイルの先頭に次のマークアップがしてあります。
実際の作業をするときには、まだそのマークアップがされていないファイルを選んでください。

    .. -*- rst -*-
    .. Groonga Project

##### 作業用のブランチを作成

作業対象のブランチを作成します。install/windows.txtを変更するので、
ブランチ名を `use-capitalized-notation-install-windows` とします。

    % git checkout -b use-capitalized-notation-install-windows

##### 編集作業

ドキュメントの「groonga」という表記を「Groonga」へと変更します。

文章だけでなく実行例も含むので単純に一括で置換するのは問題があります。
そこで「変更する箇所」と「変更しない箇所」について説明します。

変更する箇所:

-   groongaという単語をGroongaに置き換える

変更しない箇所:

-   groongaをURLの一部として使っている箇所
-   groongaをパッケージ名として使っている箇所
-   groongaをコマンド名として使っている箇所
-   groongaを実行例として使っている箇所
     * 行末が::で終わっている箇所の次のブロックは実行例となります。

例:

      Start command prompt ``cmd.exe`` and download x64 zip archive by default browser::

      > "c:Program FilesInternet Exploreriexplore.exe" http://packages.groonga.org/windows/groonga/groonga-3.0.9-x64.zip

-   groongaを特別な記法として扱っている箇所
     * 行の先頭が"..
    "となっている箇所に含まれるgroongaという単語は実行時のログを埋め込んだりするためのマークアップです。

例:

    .. groonga-command
    .. database: groonga-httpd
    .. include:: ../../example/reference/executables/groonga-httpd.log
    .. /d/status

#### ドキュメントの確認

マークアップに問題がないか、HTMLを確認します。HTMLを生成するには以下のコマンドを実行します。

    % cd doc/locale/en
    % make html

いつも使っているブラウザで該当ファイルを確認して、変更した内容が反映されていればOKです。

    % firefox html/install/windows.html

#### コミット

HTMLに問題がないことを確認できたら、コミットします。

    % cd ${cloneしたディレクトリーのトップディレクトリー}
    % git add doc/source/install/windows.txt
    % git commit

コミットするときのメッセージについては、例えば以下のようにします。

    doc: use "Groonga" notation

#### pushとpull request

ご自分のリポジトリにpushして変更点をとりこめるように公開します。

    % git push -u origin use-capitalized-notation-install-windows

ここで `use-capitalized-notation-install-windows`
は前の方の作業で作ったブランチ名です。

[GitHub #121](https://github.com/groonga/groonga/pull/121) はpull
requestのサンプルです。

ブラウザで https://github.com/(GitHubのアカウント)/groonga を開くと「
`use-capitalized-notation-install-windows` 」ブランチをpull
requestする！みたいなUIができているので、そこのボタンを押してpull
requestしてください。入力フォームがでてきますが、コミットしたときメッセージで十分なのでそのままpull
requestしてOKです！

これで、ひととおりの作業は完了しました。

まだまだできるよ!という人は
「作業ごとにやること」の「Groonga本家に追従」に戻って繰り返します。
