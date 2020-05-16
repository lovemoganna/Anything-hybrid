+++
title = "LAMBDA EXPRESSIONS"
date = 2020-03-09T00:00:00+08:00
lastmod = 2020-03-14T21:57:00+08:00
tags = ["elisp", "Lambda"]
categories = ["Lambda", "Elisp"]
draft = false
locale = "zh_CN"
+++

A lambda expression is a function object written in lisp.

<!--more-->

example:

```emacs-lisp
(lambda(x)
  "return the hyperbolic consine of X (双曲线余弦值)"
  (* 0.5 (+ (exp x) (exp (- x))))
  )
```

|        |     |                                             |                                  |
|--------|-----|---------------------------------------------|----------------------------------|
| lambda | (x) | return the hyperbolic consine of X (双曲线余弦值) | (\* 0.5 (+ (exp x) (exp (- x)))) |

In Emacs lisp,such a list is a valid expression which evaluates to a
function object.

A lambda expression,by itself,has no name;it is an anonymous
function.Althogh lamda expressions can be used this way (see [Anonymous
function](#anonymous-function)),they more commonly associated with symbols to make named
functions (See [Function Names](#function-names)).Before going into these detail,the
following subsections describe the componenets of a lambda expression
and what they do.

-   [Lambda Components](#lambda-components): The parts of a lambda expression.
-   [Simple Lambda](#simple-lambda): A simple example.
-   [Agrument list](#agrument-list): Details and special features of arguments list.
-   [Function Documentation](#function-documentation): How to put documentation in a function.


## Lambda Components {#lambda-components}

A lambda expression is a list that looks like this:

```emacs-lisp
(lambda (arg-variables...)
  [documentation-string]
  [interactive-declaration]
  body-forms...
  )
```

The first element of a lambda expresion is always the symbol lambda.
This indicates that the list represents a function.The reason
function are defined to start with lambda is so that other lists,
intended for other uses,will not accidentally be valid as
functions.

The second element is a list of symbols-**the argument variable
names**.This is called the lambda list.When a lisp function is
called,the argument values are matched up against the variables in
the lambda list,which are given local bindings with the values
provided.See [Local Variables](#local-variables).

The documentation string is a lisp string object placed within the
function definition to describe the function for the Emacs help
facilities.See [Function Documentation](#function-documentation).

The interactive declaration is a list of the form(interactive
_code-string_).This declares how to provide agruments if the
function is used interactively.Functions with this declaration are
called commands;they can be called using `M-x` or bound to a
key.Functions not intended to be called in this way should not have
interactive declaration.See [Defining Commands](#defining-commands),for how to write an
interactive declaration.

The rest of the elements are the body of the function: the lisp
code to do the work of the function (or, as a lisp programmer would
say, "a list of lisp forms to evaluate"). The value returned by the
function is the value returned by the last element of the body.


## Simple Lambda {#simple-lambda}

<a id="code-snippet--code-lambda-demo1"></a>
```emacs-lisp
(lambda (a b c) (+ a b c))
```

|        |         |           |
|--------|---------|-----------|
| lambda | (a b c) | (+ a b c) |

How to we call this lambda function?

```emacs-lisp
(funcall
 (lambda (a b c)(+ a b c))
 1 2 3)
```

```text
6
```

Note that the arguments can be the reuslts of other function
calls,as in this example:

```emacs-lisp
(funcall (lambda (a b c) (+ a b c)) 1 (* 2 3) (+ 3 4 6))
```

```text
20
```

As these examples show,you can use a form with a lambda expression
as its CAR to make local variables and give them values.

In the old days of lisp,this technique was the only way to bind and
initialize local variables.

But nowadays,it is clearer to use the special form `let` for this
purpose.(see [Local Variables](#local-variables)).Lambda Expression are mainly used as
anonymous function for passing as arguments to other function.(see
[Anonymous function](#anonymous-function)),or stored as symbol function definitions to
produce named functions(see [Function Names](#function-names)).


## Agrument list {#agrument-list}


## Function Documentation {#function-documentation}


## Anonymous function {#anonymous-function}


## Function Names {#function-names}


## Local Variables {#local-variables}

Global variables have values that last until _explicitly
superseded_ （显式的取代）with new vlaues.

When a variable has a local value,we say that it is "locally bound"
to that value,and that it is a "local variable".

For example,when a function is called,its agrument variables
receive local values,which are the actual arguments supplied to the
function call; these local bindings take effect within the body of
the function.

To take another example, the `let` special form explicitly
establishes local bindings for specific variabels,which take effect
only within the body of the `let` form.

We also speak of the `"global binding"`,which is where
(conceptually 概念上) the global value is kept.

Establishing a local binding saves away the variable 's previous
value(or lack of one).We say that the previous value is
shdowed.Both global and local values my be shadowed.It determines
the value returned by 


## Function Documentation {#function-documentation}


## Defining Commands {#defining-commands}


## Local Variables {#local-variables}


## Anonymous function {#anonymous-function}


## Function Names {#function-names}