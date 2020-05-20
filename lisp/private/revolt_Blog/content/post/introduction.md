+++
title = "Elisp introduction"
date = 2020-03-24T00:00:00+08:00
lastmod = 2020-03-24T21:01:42+08:00
tags = ["elisp"]
categories = ["elisp"]
draft = false
locale = "zh_CN"
autoCollapseToc = true
+++

Elisp Notational Conventions.

<!--more-->


## Some Trems {#some-trems}

-   the lisp reader
-   the lisp printer 
    
    the above of lexical convert textual representation of lisp
    objects into actual lisp object,and vice versa.

keywords: metasyntactic variables, agruments, function


## nil and t {#nil-and-t}

In Elisp, the symbol `nil` has three separate meanings:

-   it is a symbol with the name `'nil'`
-   it is the logical truth value `false`
-   it it the **empty list**-the list of zero elements.when used as a
    variable,nil always has the value nil.

As far as the following testing, `'()'` and `nil` are identical:

```emacs-lisp
(print (message "the value of () is %S" ())) 
(print (message "the value of nil is %S" nil))
```

```text

"the value of () is nil"

"the value of nil is nil"
```

so they stand for the same object,the symbol _nil_.

In this manual,we write `()` when we wish to emphasize that it
means the **empty list**,and we write `nil` when we wish to emphasize
that it means the truth value `false`.

```emacs-lisp
(cons 'foo ()) 				;Emphasize the empty list
(setq foo-flag nil)			;Emphasize the truth value false
```

In contexts where a truth value is expected,any `non-nil` value is
considered to be **true**.

However, **t** is the perfered way to represent the truth value
`true`.when you need to choose a vlaue that represents true,and
there is no other basic for choosing, use `t`.

```emacs-lisp
(print (message "the value of t is %S" t))
```

```text

"the value of t is t"
```

In Elisp, **nil** and **t** are special symbols that always evalute to
themselves.This is so that you do not need to **quote** them to use
them as constants in a program.


## Evaluation Notation {#evaluation-notation}

A lisp expression that you can evaluate is called a form.

Evaluating a form always produces a result,which is a Lisp Object.

When a form is macro call,it expands into a new form for lisp to
evaluate.

```emacs-lisp
(third '(a b c))			;third is a macro defined symbol call
   ==> (car (cdr (cdr '(a b c))))
   => c
```

To help describe one form,we sometimes show another form that
produces identical results.To exact equivalence of two forms is
indicated with "==".The question not big.


## Printing Notation {#printing-notation}

```emacs-lisp
(progn
  (prin1 'foo)
  (princ "\n")
  (prin1 'bar)
  )
```

```text
foo
bar
```


## Error Message {#error-message}

```emacs-lisp
(+ 34 'x)  ;error--> Wrong type argument: number-or-marker-p, x
```


## Buffer Text Notation {#buffer-text-notation}

Some examples describe modifications to the contents of a
buffers,by showing the before and after versions of the text.These
examples show the contents of the buffer in question between two
lines of dashes containing the buffer name.

```text
---------- Buffer: foo ----------
This is the -!-contents of foo.
---------- Buffer: foo ----------

(insert "changed ")
⇒ nil
---------- Buffer: foo ----------
This is the changed -!-contents of foo.
---------- Buffer: foo ----------
```


## Format of Descriptions {#format-of-descriptions}

Function,variables,macros,commands,user options,and special forms
are described in this manual in a uniform format.

The first line of a description contains the name of item followed
by its argument,if any,

The category-function,variable,or whatever appears at the beginning
of the line.The description follows on **succeeding lines**, sometimes
with examples.


### <span class="org-todo todo TODO">TODO</span> A sample Function Description {#a-sample-function-description}

In a function description,the name of the function being
descripted appears first.It is followed on the same line by a list
of argument names.These name are also used in the body of the
description,to stand for the values of the arguments.

-   The appearance of the keyword **&optional** in the argument list
    indicates subsquent arguments may be ommited (ommited agruments
    default to nil).Do not write **&optional** when you call the
    function.

-   The keyword **&rest** (which must be followed by a single argument
    name) indicates that any number of arguments can follow.The
    single argument name following **&rest** receives,as its value,a
    list of all the remaining arguments passed to the function.Do
    not write **&rest** when you call the function.
    
    Now,e.g.
    
    TODO
    
    ```emacs-lisp
    (defun foo (integer1 &optional integer2 &rest integers)
      )
    
    (foo 1 5 3 9)				;16
    (foo 5)					;14
    
    (foo w x y ...) == (+ (- x w) y ...)
    ```
    
    By convention,any arguments whose name contains the name of a
    type is expected to be of that type.(e.g. integer,integer1 or
    buffer).
    
    A plural(复数) of a type (such as buffers) often means a list of
    objects of that type.
    
    An argument named object may be of any type.
    
    For a list of Emacs object types,See `lisp Data Types`.
    
    An argument with any other sort of name (e.g. new-file) is
    specific to the function;if the function has a documentation
    string,the type of the argument should be described there.see
    `Documentation`.
    
    See `lambda Expression` ,for a more complete description of
    arguments modified by `&optional` and `&rest`.


### A simple variable description {#a-simple-variable-description}

A variable is a name that can be bound (or set) to an object.The
object to which a variable is bound is called a value(变量被绑定的对象称为值);we say also that variable holds that value.Although
nearly all veriables can be set by the users,certain variables
exist specifically so that users can change them;these are called
**user options**.Ordinary variables and user options are described
using a format like that for functions,except that there are no
arguments.