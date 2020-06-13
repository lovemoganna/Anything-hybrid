+++
title = "ploymode"
date = 2020-06-13T00:00:00+08:00
lastmod = 2020-06-13T22:39:32+08:00
draft = false
locale = "en_US"
+++

## Polymode {#polymode}


### What's the polymode {#what-s-the-polymode}

polymode 是在单个EMACS buffer里面多个major mode的一个框架.值得注意
的是,它相当灵活的遵从面向对象编程的设计.


### Install {#install}

<https://polymode.github.io/installation>


### How to use {#how-to-use}

所有 polymode 的键都是以 \`polymode-prefix-key\` 为前缀定义的,默认都
是 \`M-n\`. \`polymode-mode-map\` 是所有 polymode 键盘映射的爹.

记下键盘定义实际上没太大意义,用不惯自己改下就可以了.

| Navigation                    | Chunk Manipulation              | Exporting/Weaving/Tangling   | Evaluation of Chunks                   |
|-------------------------------|---------------------------------|------------------------------|----------------------------------------|
| polymode-next-chunk           | polymode-toggle-chunk-narrowing | polymode-tangle              | polymode-eval-region-or-chunk          |
| polymode-next-chunk-same-type | polymode-mark-or-extend-chunk   | polymode-show-process-buffer | polymode-eval-buffer-form-beg-to-point |


### Basic concept {#basic-concept}
