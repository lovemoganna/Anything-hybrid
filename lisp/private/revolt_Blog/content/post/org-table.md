+++
title = "Org Mode Table"
date = 2020-05-26T00:00:00+08:00
lastmod = 2020-06-30T22:28:26+08:00
tags = ["emacs", "orgmode"]
categories = ["emacs", "orgmode"]
draft = false
+++

Org as a spreadsheet system,just for test my poor salary

<!--more-->


## Demo {#demo}


### A simple table {#a-simple-table}

| Student  | Maths | Physics |
|----------|-------|---------|
| Bertrand | 13    | 09      |
| Henri    | 15    | 14      |
| Arnold   | 17    | 13      |

最终目的就是算出每个学生的每个学科的平均值.


### 初步认识公式 {#初步认识公式}

| Student  | Maths | Physics | Mean      |
|----------|-------|---------|-----------|
| Bertrand | 13    | 09      | [Formula] |
| Henri    | 15    | 14      |           |
| Arnold   | 17    | 13      |           |

-   设定一个公式

    也就是在 `[Formula]` 插入对应的公式来进行计算.

-   查看当前公式所在的位置

    插入公式你得知道它的location.也就是利用 `C-c ?` 来查看.

-   符号表示的含义

    比如: `[Formula]` 的位置在 Emacs Table里面的位置就是 `@2$4`,也就
    是2行4列的位置,其中 `@` 代表行, `$` 代表列.

    另外一种记法就是 `D2` ,这种记法来跟 Excel 类似,想象自己
    处在一个2维空间内即可.


### Column formulas and field formulas {#column-formulas-and-field-formulas}

| Student  | Maths | Physics | Mean |
|----------|-------|---------|------|
| Bertrand | 13    | 09      | 11   |
| Henri    | 15    | 14      |      |
| Arnold   | 17    | 13      |      |

-   field formula: 单字段公式
-   column formula: 整列公式


## Editing Text-based Tables {#editing-text-based-tables}

-   `table-fix-width-mdoe` 自动切换表格大小功能。


### Table Definition {#table-definition}

-   table-cell-vertical-char

    input `|`,press `Tab` ,you will see the beycond it:

    ```text
    ||
    ||
    ```

-   table-cell-intersection-char

    ```org
    |   |
    |---|
    |   |
    ```


### Table Creation {#table-creation}

`M-x table-insert`

```text
+-----+-----+-----+
|     |     |     |
+-----+-----+-----+
|     |     |     |
+-----+-----+-----+
|     |     |     |
+-----+-----+-----+
```


### Table Recognition {#table-recognition}

-   `table-recognize`

    demo:

    ```text
    a b c
    1 2 3
    4 5 6
    ```

    ~~------~~

    |       |
    |-------|
    | a b c |

    ~~------~~

    |       |
    |-------|
    | 1 2 3 |

    ~~------~~

    |       |
    |-------|
    | 4 5 6 |

    ~~------~~


### Cell command {#cell-command}

调整单元格的大小

-   table-highten-cell
-   table-shorten-cell
-   table-widen-cell
-   table-narrow-cell


### Cell justification {#cell-justification}


### Table Rows and Columns {#table-rows-and-columns}


### Table Conversion {#table-conversion}


### Table Misc {#table-misc}


### Converting Between Plain text and tables {#converting-between-plain-text-and-tables}

```text
1,2,3,4
5,6,7,8
9,10
```

-   `org-capture`
    1.  the column delimiter regexp: `,`
    2.  the row delimiter regexp: `C-o` (newline)
    3.  justification
    4.  the Cell width: 10

~~----------~~----------~~----------~~----------+

|   |   |   |   |
|---|---|---|---|
| 1 | 2 | 3 | 4 |

~~----------~~----------~~----------~~----------+

|   |   |   |   |
|---|---|---|---|
| 5 | 6 | 7 | 8 |

~~----------~~----------~~----------~~----------+

|   |    |   |   |
|---|----|---|---|
| 9 | 10 |   |   |

~~----------~~----------~~----------~~----------+


## Org mode table newline {#org-mode-table-newline}

ref [here](https://emacs.stackexchange.com/questions/38135/wrap-cell-content-in-an-org-mode-table).

Org mode has two type of table formats,the default `org-table` and
the other is `table.el`.

-   `org-table` demo

    | 1    | 2     | 3                    | 4  | 5     |
    |:----:|:-----:|----------------------|:--:|:-----:|
    | <12> | world | weclome sadasdasdasd | to | emacs |

<!--listend-->

-   `org-table` convert to `table`

    `C-c ~` org-table-create-with-table\\.el


## Useful link {#useful-link}

<https://www.zmonster.me/2016/06/03/org-mode-table.html>


## org table wrap multi line {#org-table-wrap-multi-line}

-   `C-c TAB`
