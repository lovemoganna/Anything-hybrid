+++
title = "Org Mode Table"
date = 2020-05-26T00:00:00+08:00
lastmod = 2020-05-26T15:37:23+08:00
tags = ["emacs", "orgmode"]
categories = ["emacs", "orgmode"]
draft = false
+++

Org as a spreadsheet system,just for test my poor salary

你可能很难理解,为什么我要忍受这无聊的生活.

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