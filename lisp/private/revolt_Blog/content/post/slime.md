+++
title = "Slime"
date = 2020-03-19T00:00:00+08:00
lastmod = 2020-03-27T15:52:19+08:00
tags = ["slime", "commonlisp"]
categories = ["slime"]
draft = false
locale = "zh_CN"
autoCollapseToc = true
+++

learn how to use Slime mode in Emacs.

<!--more-->

Lisp mode supports editing lisp source files,slime mode adds
supports for interacting with a running Common Lisp process for
compilation,debugging,documentation lookup,and so on.

The slime mode programming environment follows the example of
Emacs's native Elisp environment.

SLIME is constructed from two parts: a user-interface written in
Emacs lisp,and a supporting server program written in Common
lisp.The two sides are connected together with a socket and
communicate using an RPC[^fn:1]-like protocol.

The Lisp Server is primarily written in protable Common lisp.The
required implementation-specific functionality is specified by a
well-defined interface and implemented separately for each lisp
implementation.This makes SLIME readily protable.


## GETTING STARTED {#getting-started}


### Platforms {#platforms}

Support all platforms,Most features work uniformly across
implementations,but some are prone to variation.These include the
precision of placing compiler-note annotations,XREF support,and
fancy debugger commands (like "restart frame")


### Downloading {#downloading}

just search git reposity,add the configeration into your emacs
config file:

```emacs-lisp
;; -*-Emacs-lisp-*-
(setq inferior-lisp-program "/usr/bin/sbcl")

(setq slime-contribs '(slime-fancy))
```

once you press `M-x slime`.This use the inferior-lisp package to
start a lisp process,loads and starts the lisp-side server(named
as "Swank"),and establishes a socket connection between Emacs and
lisp.Finally a REPL buffer is created where you can enter Lisp
expressions for evaluation.

If the basic setup is working,we can try additional modules.now
could try to run `Loading Contrib Packages`.


### Loading Contrib Packages {#loading-contrib-packages}

Contrib packages aren't loaded by default.You have to modify your
setup a bit so that Emacs knows where to find them and which of
them to load.Generally,you set the variable `slime-contribs` with
the list of package-names that you want to use.e.g.,a setup to
load the `slime-scratch` and `slime-editing-commands` packages
looks like:

```emacs-lisp
;; starting slime,the commands of both packages should be available
(setq slime-contribs '(slime-scratch slime-editing-commands))

;; slime-fancy is a meta package which loads a combination of the most popular packages.
;;(setq slime-contribs '(slime-fancy))

;;(setq slime-contribs '(slime-repl))  ;repl only
```


### Installation {#installation}


### Running {#running}


### Setup Tuning {#setup-tuning}

[^fn:1]: [Remote Procedure Call(RPC)](https://searchapparchitecture.techtarget.com/definition/Remote-Procedure-Call-RPC)