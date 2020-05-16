+++
title = "ELISP FAQ"
date = 2020-02-25T00:00:00+08:00
lastmod = 2020-03-24T17:09:33+08:00
tags = ["elisp", "faq"]
categories = ["elisp"]
draft = false
locale = "zh_CN"
+++

There have a little Elisp question.

<!--more-->


## How to use \` {#how-to-use}


## How to use &rest and &optional {#how-to-use-and-rest-and-and-optional}


### &rest {#and-rest}

```emacs-lisp
(info "(elisp)Argument List")		;see more information about &rest
```


### &optional {#and-optional}


## How to download file use org mode {#how-to-download-file-use-org-mode}

```text
#+begin_src shell :results file link :file "Results-of-Evaluation.html" :output-dir ./ :exports result
wget "https://orgmode.org/manual/Results-of-Evaluation.html"
#+end_src

#+RESULTS:
[[file:./Results-of-Evaluation.html]]
```


## How to move another buffer point {#how-to-move-another-buffer-point}

-   `C-M v`
-   `C-M-S v`


## How to mark a location in use evil mdoe {#how-to-mark-a-location-in-use-evil-mdoe}

-   `m a`
-   `` ` a `` --- jump your marked location
-   `'a` --- jump your marked location line
-   `:marks` --- show all marks location
-   `:delmarks! / :delmarks` --- delete all marks or one special mark.


## elisp - multiple line print in org mode {#elisp-multiple-line-print-in-org-mode}

```emacs-lisp
(setq my-list '(apple orange peach))
(print (car my-list))
(print (cdr my-list))
```