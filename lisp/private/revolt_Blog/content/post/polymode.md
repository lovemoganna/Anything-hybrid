+++
title = "Ploymode"
date = 2020-06-13T00:00:00+08:00
lastmod = 2020-06-14T17:02:54+08:00
draft = false
locale = "en_US"
+++

What's the polymode?

polymode 是在单个EMACS buffer里面多个major mode的一个框架.值得注意
的是,它相当灵活的遵从面向对象编程的设计.

<!--more-->


## Install {#install}

<https://polymode.github.io/installation>


## How to use {#how-to-use}

所有 polymode 的键都是以 \`polymode-prefix-key\` 为前缀定义的,默认都
是 \`M-n\`. \`polymode-mode-map\` 是所有 polymode 键盘映射的爹.

记下键盘定义实际上没太大意义,用不惯自己改下就可以了.

| Navigation                    | Chunk Manipulation              | Exporting,Weaving,Tangling   | Evaluation of Chunks                   |
|-------------------------------|---------------------------------|------------------------------|----------------------------------------|
| polymode-next-chunk           | polymode-toggle-chunk-narrowing | polymode-tangle              | polymode-eval-region-or-chunk          |
| polymode-next-chunk-same-type | polymode-mark-or-extend-chunk   | polymode-show-process-buffer | polymode-eval-buffer-form-beg-to-point |


## Basic concept {#basic-concept}

内部的 `ploymode` 使用间接buffer来实现不同mode间的内部扫描.在
polymode buffer里的每个内部的major mode有它自己的间接buffer来和它关
联. `Host mode` 存活在 base buffer里面.因此,在polymode里面跳转mode
就跟跳转emacs buffer一样快,因为它不跟其他 `MMM`&nbsp;[^fn:1] 一样,不重新
install major mode. 

By sibling buffers,we mean `base` or `indirect` buffers which are
shared with the current buffer.


### Terminlogy {#terminlogy}

span
: 是在EMACS同一major mode下的相邻和相同的文本区域.
    主要有4种类型的spans: `head`, `body`, `tail`, `host`.
    所有的spans都是左侧封闭,右侧开放的.例如,一个span扫描
    [3,5) 包含在位置3的字符,但是不包含位置5的字符.这是和
    EMACS的函数处理文本属性相一致的.

chunk
: 由一个或者多个 `spans` 组成的相邻区域.这里主要有两种类
    型的chunks:
    1.  `host chunks`: 在host major mode中只包含一个 `span`.
    2.  `inner chunks`: 通常包含 `head`, `body`, `tail`, 这里的body指
        的是一些非host的一些其他mode.


polymode
: 意味着下列其中之一:
    1.  在EMACS buffer里有效关联函数的汇总
    2.  在EMACS buffers中install 函数bunch. Polymode可以使用像其他
        EMACS major mode,(例如在 `auto-mode-alist` 里放置),或者像一个
        major mode一样,为了在存在的EMACS mode 里install 函数.
    3.  一个为polymode掌管配置的类对象 `pm-polymode`.


chunkmode
: 更加特殊的 `hostmode` 和 `innermode` 含义
    1.  在host和inner chunks里关联函数的汇总
    2.  由 `pm-host-hostmode`, `pm-inner-innermode`,
        `pm-inner-auto-chunkmode` 划分的配置对象.


### Configuration {#configuration}

Host 和 inner chunks 通过 `pm-chunkmode` 类划分的对象被配置,
`pm-chunkmode` 通常被引用作为 `chunkmodes`. 这些对象名字形式
`poly-XYZ-hostmode` and `poly-XYZ-innnermode` 分别被引用作为
`hostmodes` and `innermodes`.

Polymodes 通过名带 `poly-XYZ-polymode` SCHEME的 `pm-polymode` 类对
象来配置,这里的 `XYZ` 和在polymode函数 `poly-XYZ-mode` 里的一样.
`poly-XYZ-polymode` 对象中的polymode在初始化期间被克隆并被存储在一
个buffer-local variable `pm/polymode` 当中.此对象在所有sibling
buffers之间被分享.

`Chunks` 和 `chunkmodes` 是不同的概念.Chunk 是一个文本片段,在一个
buffer的同一个mode当中里面可能会有多个chunks.相比之下,每个buffer只
有一种类型的chunkmode,每个chunk当中的行为通过chunkmode来明确.


### Class Hieracrhy {#class-hieracrhy}

Polymode package uses `eieio` 来代表它的对象. 对所有 polymode类来
讲,Root Class是 `eieio-instance-inheritor`,它提供了基于 `inheritance`
的 `prototype`. 这意味着来源于polymode类的对象继承可以被克隆,为了
动态的创建自定义对象的层次结构.

Instance inheritance(or prototype inheritance) 意味着如果你改变一
个父类对象的slot(插槽),所有的对象的子类和孙子类将会inherit 新值,除
非它们明确的覆盖了插槽.

这里有一些已经被定义的对象的bunch,你可以在 `polymode`,
`poly-hostmodes`, 和 `poly-innermodes` 自定义组里检查下.

Polymode Class Hierarchy:

```text
+--eieio-instance-inheritor
   +--pm-root
       +--pm-polymode
       +--pm-chunkmode
       |    +--pm-inner-chunkmode
       |    |    +--pm-inner-auto-chunkmode
       |    +--pm-host-chunkmode
       +--pm-weaver
       |    +--pm-shell-weaver
       |    +--pm-callback-weaver
       +--pm-exporter
	    +--pm-shell-exporter
	    +--pm-callback-exporter
```


### General Naming Conventions {#general-naming-conventions}

User facing functionality is named with `polymode-`
prefix. Polymodes are named with `poly-XYZ-mode` convention. Host,
inner and polymode configuration objects are named
`poly-XYZ-hostmode`, `poly-XYZ-innermode` and
`poly-name-polymode`. Classes, methods and developer-oriented API
have `pm-` prefix.


## Defining Polymodes {#defining-polymodes}

Defining polymodes always starts with defining(or reusing) a hostmode and one
or more innermodes.


### Hosts Modes {#hosts-modes}

define the markdown hostmode:

```emacs-lisp
(define-hostmode poly-markdown-hostmode
  :mode 'markdown-mode)
```

`define-hostmode` is a macro which,in this case,defines an object
`poly-markdown-hostmode` of class `pm-host-chunkmode`. 关键参数是
slots,最重要的存在 `:mode` 意味着 emacs的 major mode应该在host
chunks里面安装.

当提供通过被子类继承父类的整个配置的时候.对于 `define-hostmode` 第
二个可选参数的选项是父类hostmode.一个更加宽泛范围的hostmodes已经在
`polymode-base.el` file中定义.你可以在你自己的 polymodes里面重新使
用.


### Inner Modes {#inner-modes}

Polymode defines two built-in types of innermodes.

-   `pm-inner-chunkmode` 允许在高级mode里面预先指定.
-   `pm-inner-auto-chunkmode` 即时 `span` 检测body的major mode.

下面是对markdown的 YAML metadata的innermode:

```emacs-lisp
(define-innermode polymode-markdown-yaml-metadata-innermode
  :mode 'yaml-mode
  :head-matcher "\`[ \t\n]*---\n"
  :tail-matcher "^---\n"
  :head-mode 'host
  :tail-mode 'host
  )
```

和一个围起来的代码的 auto innermode:

```emacs-lisp
(define-auto-innermode poly-markdown-fenced-code-innermode
  :head-matcher (cons "^[ \t]*\\(```{?[[:alpha:]].*\n\\)" 1)
  :tail-matcher (cons "^[ \t]*\\(```\\)[ \t]*$" 1)
  :mode-matcher (cons "```[ \t]*{?\\(?:lang *= *\\)?\\([^ \t\n;=,}]+\\)" 1)
  :head-mode 'host
  :tail-mode 'host)
  )
```

`:head-matcher` 和 `:tail-matcher` 中的所有例子都是用来搜索 inner
code chunks heads 和 tails正则表达式匹配模式. `:mode-matcher` 告诉
polymode如何从chunk的head中找到major mode.三个matchers没一个都可以
是一个regexp,一个(regex or submatch)样式的cons,或者应该返回mode名
字的函数.

`:head-mode` 和 `:tail-mode` 指定的major mode分别用于head 和
tail.特殊符号 `'host` 意味着 `host mode` 被用于head or tail.如果
`'body`,即 chunk's body 的mode.Head and tail mode 默认是
`poly-head-tail-mode`,这是非常基本的 prog mode,没有特殊功能.

anonymous mode(aka mode-less)chunks 或者major mode 无法识别
的情况,对于body span,Buffer local `polymode-default-inner-mode` 可
以被指定默认的mode.当这个变量是 `nil` (默认)时,即是一个 `host
    mode`,也是一个已经被安装的特殊 `poly-fallback-mode`.这个mode被安装
取决于innermode配置对象 `:mode` 插槽的值.


### <span class="org-todo todo TODO">TODO</span> Polymodes {#polymodes}

最终,使用 host and inner modes定义要比定义 `poly-markdown-mode`
polymode 要更容易:

```emacs-lisp
(define-polymode poly-markdown-mode
  :hostmode 'pm-host/markdown
  :innermodes '(poly-markdown-yaml-metadata-innermode
		poly-markdown-fenced-code-innermode)
  )
```

`define-polymode` 跟标准EMACS工具集 `define-derived-mode` 和
`define-minor-mode` 相同.它接受一些可选参数:

-   `PARENT` polymode可以被划分
-   在chunkmodes安装期间, `DOC` string and `BODY` 在host和indirect
    buffer中被执行
-   可以在 `BODY` 前添加键值进一步完善配置,
-   到目前为止,大多数 common keys 是 `:hostmode` 指定
    `pm-host-chunkmode` 对象的名字(symbol),以及 `:innermode`,即
    `pm-inner-chunkmode` 对象的列表名.详情参见 `define-polymode`.

大多数 polymodes 被设计用作major mode.(i.e. in `auto-mode-alist`
or buffer-local `mode:` cookie).

很遗憾,不知道如何使用.暂时搁置.

[^fn:1]: MMM: Multiple Major Mode
