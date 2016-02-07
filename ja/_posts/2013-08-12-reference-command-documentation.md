---
layout: post.ja
title: リファレンスコマンドのドキュメントをよいものにしていきませんか?
description: リファレンスコマンドのドキュメントをよいものにしていきませんか?
---

リファレンスコマンドのドキュメントをよいものにしていきませんか?
---------------------------------------------------------------

長い間懸案であった、groongaのAPIのドキュメント化については @whombx
さんのおかげで一区切りつきました。そこで、次はリファレンスコマンドを整理する作業にとりかかりたいなぁと思っています。

ドキュメントを随時追加しているのですが、リファレンスマニュアルの
[コマンド](http://groonga.org/ja/docs/reference/command.html)
については、新旧のフォーマットが混在していて、統一されていないのが現在の課題となっています。

そこで、新しいフォーマットに統一する必要があるのですが、ここをお手伝いいただけると嬉しいです。

では具体的にどんなことをやればいいのかを説明します。基本的にはコマンドごとにpull
requestを送ってもらうと進めやすいです。

対象となるコマンドは次のとおりです。

-   cache_limit
-   check
-   clearlock
-   column_create
-   column_list
-   column_remove
-   define_selector
-   defrag
-   delete
-   dump
-   log_level
-   log_put
-   log_reopen
-   quit
-   register
-   shutdown
-   status
-   suggest
-   table_list
-   table_remove

あまりGitHubでの作業に慣れていなくてもできるように、「最初にやること」と「作業ごとにやること」、「関数ごとにやること」に分けて順に説明します。

-   最初にやること
-   作業ごとにやること
-   コマンドごとにやること

### 最初にやること

以下では、最初に一度だけ実施しておけば良いことを説明します。

#### 最初の設定

まずは、gitの設定をしましょう。すでにある程度gitを使っている場合には初期設定はすでに完了しているかも知れません。その場合には飛ばして構いません。

    % git config --global user.name "あなたのユーザー名"
    % git config --global user.email "あなたのメールアドレス"

上記はコミットログに使われます。公開しても差し支えないユーザ名もしくはメールアドレスを設定します。

#### GitHubでforkする

GitHubにアカウントがなければ用意してください。アカウントが用意できたら、ログインした状態で以下のURLにアクセスします。

-   [groongaリポジトリをforkする](https://github.com/groonga/groonga/fork)

リポジトリ選択画面でご自分のリポジトリへとforkしてください。

#### 作業用リポジトリの初期設定

次は作業用にforkしたリポジトリを手元にcloneします。このとき、本家の変更に追従するための設定を行います。

    % git clone git@github.com:(あなたのGitHubのアカウント)/groonga.git
    % cd groonga
    % git remote add upstream git@github.com:groonga/groonga

#### ドキュメントビルド用の初期設定

ドキュメントを生成するために以下を実行します。

    % ./autogen.sh
    % ./configure --enable-document

ここまでで、「最初にやること」は完了です。次は「作業ごとにやること」へと進みます。

### 作業ごとにやること

以下では作業ごとにやることを説明します。

#### groonga本家に追従する

groonga本家の最新状態に追従して、作業がかぶらないようにします。

    % git fetch --all
    % git checkout master
    % git rebase upstream/master

最新の状態に追従できたら、「コマンドごとにやること」へと進みます。

### コマンドごとにやること

以下では、例えば `cache_limit`
の作業をする場合で説明します。作業対象となるファイルは、リポジトリのdoc/source/reference/commands/以下にあります。
`cache_limit`
の場合は、doc/source/reference/commands/cache_limit.txtとなります。

#### 作業用のブランチを作成

作業対象のブランチを作成します。

    % git checkout -b cache-limit

#### 編集作業

ドキュメントの体裁を以下のように変更します。

旧:

-   名前
-   書式
-   説明
-   引数
-   返値
-   例

新:

-   Summary (名前のセクションから移動)
-   Syntax (書式のセクションから移動)
-   Usage (例のセクションから移動)
-   Parameters (引数のセクションから移動)
-   Return value (返値のセクションから移動)

新しいほうのフォーマットに直してあるものは
[コマンド一覧](/ja/docs/reference/command.html)
で見たときにコマンド名がボールド体で表記されます。 例えば
`column_rename` や `load` 、 `normalize`
コマンドなどは新しいスタイルになっています。

中には本文が英訳されていないものもありますが、英訳はしなくて構いません。
新しいスタイルにドキュメントを更新するというのを機械的に行っていただければOKです!

#### ドキュメントの確認

マークアップに問題がないか、HTMLを確認します。HTMLを生成するには以下のコマンドを実行します。

    % cd doc/locale/en
    % make html

いつも使っているブラウザで該当ファイルを確認して、移動した内容が追加されていればOKです。

    % firefox html/reference/commands/cache_limit.html

#### コミット

HTMLに問題がないことを確認できたら、コミットします。

    % cd ${cloneしたディレクトリーのトップディレクトリー}
    % git add doc/source/reference/commands/cache_limit.txt
    % git commit

コミットするときのメッセージについては、例えば以下のようにします。

    doc: follow new markup guideline about cache_limit command documentation

#### pushとpull request

ご自分のリポジトリにpushして変更点をとりこめるように公開します。

    % git push -u origin cache-limit

ここで `cache_limit` は前の方の作業で作ったブランチ名です。

ブラウザで https://github.com/(GitHubのアカウント)/groonga を開くと「
`cache-limit` 」ブランチをpull
requestする！みたいなUIができているので、そこのボタンを押してpull
requestしてください。入力フォームがでてきますが、コミットしたときメッセージで十分なのでそのままpull
requestしてOKです！

これで、ひととおりの作業は完了しました。

まだまだできるよ!という人は
「作業ごとにやること」の「groonga本家に追従」に戻って繰り返します。
