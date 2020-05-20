+++
title = "Elisp Basic"
date = 2020-03-24T00:00:00+08:00
lastmod = 2020-03-24T17:06:35+08:00
tags = ["elisp", "basic"]
categories = ["elisp", "basic"]
draft = false
locale = "zh_CN"
autoCollapseToc = true
+++

Elisp Basic Example.

<!--more-->


## Printing {#printing}

```emacs-lisp
; printing variable values
(message "Her age is: %X" 12)	     ; %X is hex 
(message "Her age is: %o" 16)        ; %o is octal 
(message "Her age is: %.2f" 16)        ; %f 
(message "Her age is: %.2e" 16)        ; %e
(message "Her age is: %.2g" 12)        ; %g
(message "Her age is: %.2c" 12)        ; %c,means print a number as a single characters.
(message "Her name is: %s" "Vicky")  ; %s is for string
(message "My list is: %S" (list 8 2 3))  ; %S is for any lisp expression
```

```emacs-lisp
(message "Her age is: %d" 16)        ; %d is for number
```

```text
Her age is: 16
```

```emacs-lisp
(message "Her age is: %x" 12)        ; %x is hexq 
```