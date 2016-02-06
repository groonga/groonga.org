---
layout: post.ja
title: grn_pat_cursor の仕様
---

## grn_pat_cursor の仕様

grn_dat_cursor の内部実装に際して，必要となる機能をはっきりさせるため，grn_pat_cursor の仕様についてまとめてみました．ポイントは grn_pat_cursor_open() における *min*, *max*, *flags* の連携です．

by やた．

### 概要

grn_pat の機能は辞書です．新しく追加されたキーに ID を割り当てたり，検索で見つけたキーの ID を返したり，ID からキーを復元したりできます．これらの基本的な機能を提供する関数が grn_pat_add(), grn_pat_get(), grn_pat_get_key() です．

では grn_pat_cursor が何を担当するのかというと，grn_pat の拡張的な検索方法を提供するべく用意されています．その内容は，範囲検索，Common prefix search に Predictive search です．実際に grn_pat
が提供している検索方法は以下のようになっています．

- 範囲検索
    - ID 順 範囲検索
        - 2 つの文字列 *min*, *max* を受け取り，ID が *min* 's ID と *max* 's ID の間にあるキーを検索します．
        - 例： *min* 's ID == 10, *_max_* 's ID == 30 であれば，10 から 30 までの ID が割り当てられたキーが検索結果に含まれます．
    -   辞書順 範囲検索
        -   2 つの文字列 *min*, *max* を受け取り，辞書順に見て *min* と *max* の間にあるキーを検索します．
        -   例： *min* == "apple", *max* == "orange" であれば，"banana" や "melon" などが検索結果に含まれます．"watermelon" は "orange" より大きいので含まれません．
-   Common prefix search
    -   クエリ *query* の前半部分に一致するキーを検索します．
        -   例： *query* == "additional" であれば，"add", "addition", "additional" などが検索結果に含まれます．
- Predictive search
    -   クエリ *query* で始まるキーを検索します．
        - 例： *query* == “add” であれば，"add", "addition","additional" などが検索結果に含まれます．

辞書順の範囲検索や Common prefix search, Predictive search はトライの特徴的な検索方法です．grn_pat_cursor の利用にあたっては，複数のキーがマッチするかもしれないところがポイントになります．検索結果を配列に受け取るようなインタフェースと比べた場合，検索結果を一つずつ取り出せる grn_pat_cursor の方が，様々な状況に柔軟に対処できます．たとえば，クエリにマッチするキーがたくさんある場合でも，先頭の 10 個だけを取り出したり，後半の 10 個だけを取り出したり，あるいは途中の 10 個を取り出したり，目的のキーを見つけた時点で終了したりすることが可能です．

Geo search などに利用されています．

### 詳細

基本的な機能は上述の通りですが，grn_pat_cursor では，検索結果の順番や下限・上限の扱い方などを設定できます．以下，もう少し詳しく説明します．

#### ID 順 範囲検索

ID の範囲については，キーの文字列により指定するようになっています．未登録の文字列を指定したときは，検索結果が空になります．下限および上限の設定を省略することにより，それぞれ下限なしと上限なしの設定が可能です．オプションにより，検索結果の昇順・降順を切り替えることができます．また，下限・上限を検索結果に含めるかどうかを変更できます．

#### 辞書順 範囲検索

文字列の範囲については，未登録の文字列による指定が可能です．たとえば，下限を "a", 上限を "b" として，下限を検索結果に含め，上限を検索結果に含めないことにより，"a" で始まるキーを検索できます．ID
順の範囲検索と同様に，下限および上限の設定を省略することで，それぞれ下限なしと上限なしの設定が可能です．オプションにより，検索結果の昇順・降順や下限・上限を検索結果に含めるかどうかを変更できます．

#### Common prefix search

クエリにマッチするキーを長い方から順に返すようになっています．他の検索方法とは異なり，昇順・降順を変更することはできません．また，クエリと完全一致するキーを検索結果から除くオプションもありません．唯一のオプションとして，キーの長さの下限を設定することが可能です．

#### Predictive search

Common prefix search とは異なり，キーの長さを制限することはできません．その代わり，検索結果の昇順・降順に加えて，クエリに完全一致するキーを検索結果に含めるかどうかを切り替え可能です．

### インタフェース

grn_pat_cursor の基本的な使い方は，grn_pat_cursor_open() でカーソルを作成し，grn_pat_cursor_next() で一つずつ検索を進め，最後に grn_pat_cursor_close() でカーソルを破棄するという流れになります．grn_pat_cursor_next() により進めた検索の結果は，grn_pat_cursor_get_key() などによって取得できます．カーソルを作成した後，grn_pat_cursor_next() を呼び出してから一つ目の検索結果を取り出すことができます．

もっとも重要な関数が grn_pat_cursor_open() です．検索方法の切り替えからオプションの指定にいたるまで，すべての設定を一度におこないます．後の関数については，検索方法にかかわらず同じ使い方になるので省略します．

    GRN_API grn_pat_cursor *grn_pat_cursor_open(grn_ctx *ctx, grn_pat *pat,
                                                const void *min, unsigned int min_size,
                                                const void *max, unsigned int max_size,
                                                int offset, int limit, int flags);
                                                
検索方法の切り替えに用いるのは *flags* と *min*, *max* です．残る引数は，検索結果の先頭 *offset* 個をスキップしたり，取り出せる検索結果の数を最大で *limit* 個に制限したりするためのオプションになっています． *limit* == –1 は制限なしを意味します．詳細は後述します．

    GRN_API grn_id grn_pat_cursor_next(grn_ctx *ctx, grn_pat_cursor *c);

検索を進めて，次にマッチしたキーの ID を返します．検索条件にマッチするキーが他に存在しないときや，検索結果の数がすでに *limit* 個に到達しているときは GRN_ID_NIL を返します．

    GRN_API void grn_pat_cursor_close(grn_ctx *ctx, grn_pat_cursor *c);

grn_pat_cursor の終了処理です．

    GRN_API int grn_pat_cursor_get_key(grn_ctx *ctx, grn_pat_cursor *c, void **key);

grn_pat_cursor_next() の後で呼び出すことにより，最後にマッチしたキーの文字列を受け取ることができます．*c* が内部に文字列を格納するためのバッファを持っていて，そのバッファの開始位置が *\*key* に書き込まれるようになっています．成功すればキーの長さ（1 以上）を返し，そうでなければ 0，もしくはエラーコード（-1 以下）を返します．

以下，grn_pat_cursor_open() による各種検索についての説明になっています．

#### ID 順 範囲検索

*flags* に GRN_CURSOR_BY_ID が指定されている場合，ID が *min* 's ID 以上 *max* 's ID 以下のキーを検索します． *flags* に GRN_CURSOR_ASCENDING / DESCENDING を指定することにより，昇順・降順の制御が可能です．また， *flags* に GRN_CURSOR_LT / GT を指定すれば，それぞれ *min*, *max* に完全一致するキーを検索結果から取り除くことができます．

#### 辞書順 範囲検索

*flags* に GRN_CURSOR_BY_KEY が指定されている場合， *min* 以上 *max* 以下のキーを検索します． *flags* に GRN_CURSOR_ASCENDING / DESCENDING を指定することにより，昇順・降順の制御が可能です．また， *flags* に GRN_CURSOR_GT / LT を指定すれば，それぞれ *min*, *max* に完全一致するキーを検索結果から取り除くことができます．

#### Common prefix search

*flags* に GRN_CURSOR_PREFIX が指定されており，さらに *max* != NULL かつ *max_size* != 0 の場合， *min* を基準とする Common prefix search になります．このとき， *min* の内容は無視されます．ただし，長さが *min_size* より短いキーは検索結果から取り除かれます．

#### Predictive search

*flags* に GRN_CURSOR_PREFIX が指定されており，さらに *max* == NULL もしくは *max_size* == 0 の場合， *min* を基準とする Predictive search になります． *min*  NULL のときは _min_size_ == 0
と同様の動作になる（すべてのキーが検索結果に含まれる）ことに注意が必要です．なお，*max* == NULL のとき *max_size* に 0 以外の値を指定しても無視されます．*flags* に GRN_CURSOR_ASCENDING / DESCENDING を指定することにより，昇順・降順の制御が可能です．また， *flags* に GRN_CURSOR_GT を指定すれば， *max* に完全一致するキーを検索結果から取り除くことができます．
