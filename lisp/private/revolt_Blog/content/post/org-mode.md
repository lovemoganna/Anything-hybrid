+++
title = "Org Mode"
date = 2020-02-24T00:00:00+08:00
lastmod = 2020-05-26T10:51:17+08:00
tags = ["emacs", "orgmode"]
categories = ["emacs", "orgmode"]
draft = false
+++

Org can edit, format, extract, export, and publish source code blocks.

Org can also compile and execute a source code block, then capture the results.

Users can control how live they want each source code block by
tweaking the header arguments (see Using Header Arguments) for
compiling, execution, extraction, and exporting.

<!--more-->

Org can also link a compiler error message to the appropriate line
in the source code block.

An important feature of Org’s management of source code blocks is the
ability to pass variables, functions, and results to one another using
a common syntax for source code blocks in any language.


## Structure of Code Blocks {#structure-of-code-blocks}

A source code block conforms to this structure:

```text
#+NAME: <name>
#+BEGIN_SRC <language> <switches> <header arguments>
  <body>
#+END_SRC
```

An inline code block conforms to this structure:

```text
src_<language>{<body>}
```

or

```text
src_<language>[<header arguments>]{<body>}
```

-   `‘#+NAME: <name>’`

    Org mode requires unique names. For duplicate names, Org mode’s
    behavior is undefined.

<!--listend-->

-   `‘<switches>’`

    Switches provide finer control of the code execution, export, and
    format. see [Literal Examples](#literal-examples)

<!--listend-->

-   `'<header arguments>'`

    Heading arguments control many aspects of evaluation, export and
    tangling of code blocks.Using Org’s properties feature, header
    arguments can be selectively applied to the entire buffer or
    specific sub-trees of the Org document.


## Literal Examples {#literal-examples}

1.特殊符号，防止歧义。

```text
* I am no real headline
```

Here is an example

```text
Some example from a text file.
```

2.显示行号

{{< highlight emacs-lisp "linenos=table, linenostart=20" >}}
;; This exports with line number 20.
(message "This is line 21")
{{< /highlight >}}

{{< highlight emacs-lisp "linenos=table, linenostart=31" >}}
;; This is listed as line 31.
(message "This is line 32")
{{< /highlight >}}

3.定位到代码位置（在导出的HTML里面生效）

{{< highlight emacs-lisp "linenos=table, linenostart=1" >}}
(save-excursion
				(goto-char (point-min))
{{< /highlight >}}

In line 1 we remember the current position. Line 2
jumps to point-min.

4.when exporting the contents of the block. However, you can use
the ‘-i’ switch to also preserve the global indentation, if it does
matter. See Editing Source Code。缩进的设置。

{{< highlight emacs-lisp "linenos=table, linenostart=1" >}}
(message "This is line 32")
{{< /highlight >}}


## Using Header Arguments {#using-header-arguments}

Since header arguments can be set in several ways, Org prioritizes
them in case of overlaps or conflicts by giving local settings a
higher priority.

Header values in function calls, for example, override header
values from global defaults.


### System-wide header arguments {#system-wide-header-arguments}

System-wide values of header arguments can be specified by
customizing the org-babel-default-header-args variable, which
defaults to the following values:

{{< highlight text "linenos=table, linenostart=1">}}
    :session    => "none"
    :results    => "replace"
    :exports    => "code"
    :cache      => "no"
    :noweb      => "no"
{{< /highlight >}}


### Header arguments in Org mode properties {#header-arguments-in-org-mode-properties}

`#+PROPERTY: header-args:Emacs-lisp  :session *Emacs-lisp*`

For header arguments applicable to the buffer, use ‘PROPERTY’
keyword anywhere in the Org file

<a id="code-snippet--elsip-variable"></a>
```emacs-lisp
(message (number-to-string a))
```

```text
1
```

_now here is a test demo_:

`(message (number-to-string 1))` `1`

<a id="code-snippet--get-date"></a>
```http
GET http://date.jsontest.com
```

```text
HTTP/1.1 200 OK
Access-Control-Allow-Origin: *
Content-Type: application/json
X-Cloud-Trace-Context: 6651d80a2a9aedface50a6a8634d1112
Date: Sat, 14 Mar 2020 17:12:21 GMT
Server: Google Frontend
Content-Length: 100

{
   "date": "03-14-2020",
   "milliseconds_since_epoch": 1584205941375,
   "time": "05:12:21 PM"
}
```

now call the `get_date` function,the following of the result:

```text
{
   "date": "03-14-2020",
   "milliseconds_since_epoch": 1584206033817,
   "time": "05:13:53 PM"
}
```

inline block multi problem,now it is:

Inline source code is only supposed to create one-line results. If
you write code that generates multiple result lines, an error is
raised: Inline error: multiline result cannot be used

`src_emacs-lisp[:results value]{(princ "hha\nyesyesyes")}`

`(princ "hha")` `hha`

you could run it and test it.


### Code block specific header arguments {#code-block-specific-header-arguments}

Multi-line header arguments on an unnamed code block:

```emacs-lisp
(message "data1:%S, data2:%S" data1 data2)
```

Multi-line header arguments on a named code block:

<a id="code-snippet--named-block"></a>
```emacs-lisp
(message "data:%S" data)
```


### <span class="org-todo todo TODO">TODO</span> Header arguments in function calls {#header-arguments-in-function-calls}

Header arguments in function calls are the most specific and
override all other settings in case of an overlap.

They get the highest priority. Two ‘#+CALL:’ examples are shown
below.

;#+CALL: name-block(data=3) :exports results

;#+CALL: name-block[:session special](data=5)


#### Evaluating Code Blocks {#evaluating-code-blocks}

<!--list-separator-->

-  Code Evaluation and Security Issues

    just set the variable `org-confirm-babel-evaluate` nil, org
    executes code blocks without prompting the user for
    confirmation.

    Each source code language can be handled separately through this
    function argument.

    ```text
    (defun my-org-confirm-babel-evaluate (lang body)
      (not (string= lang "ditaa")))  ;don't ask for ditaa
    (setq org-confirm-babel-evaluate #'my-org-confirm-babel-evaluate)
    ```

    here test `emacs-lisp` :

    ```emacs-lisp
    (message "%s - %s" "hello" "world")
    ```

<!--list-separator-->

-  How to Evaluate Code Blocks

    Org captures the results of the code block evaluation and
    inserts them in the Org file, right after the code block.

    By calling a named code block from an Org mode buffer or a
    table. Org can call the named code blocks from the current Org
    mode buffer or from the “Library of Babel”.

    The syntax for ‘CALL’ keyword is:

    ```text
    ... call_<name>(<arguments>) ...
    ... call_<name>[<inside header arguments>](<arguments>)[<end header arguments>] ...
    ```

    -   _name_ 参数的使用

        假设我们需要调用其他文件里面的函数 [demo-one](org_call_test)，则需要按照以下方
        法来进行操作:

        ```text
        #+CALL: org_call_test:sayHello()

        #+RESULTS:
        : "hello world"
        ```

        -   org\_call\_test 是一个文件
        -   sayHello 是上面文件的一个名字为 `sayHello` 的代码块。

    -   _arguments_ 参数的使用

        现在我在另外一个文件中的 `org_call_test` 中，名为 `sayHello` 的
        代码块中的代码如下：

        <a id="code-snippet--sayHello"></a>
        ```emacs-lisp
        (defun sayHello(n)
          (format "%s" (message (number-to-string n))))
        (sayHello n)
        ```

        现在咱们调用它，如下：

        ```text
        #+CALL: org_call_test:sayHello(n=5)

        #+RESULTS:
        : 5
        ```

    -   _inside header arguments_ 参数的使用

        Org passes inside header arguments to the named code block
        using the header argument syntax. Inside header arguments apply
        to code block evaluation.

        ```text
        #+CALL: org_call_test:sayHello(n=5) [:results output]

        #+RESULTS:
        : 5
        ```

    -   _end header agruments_ 参数的使用

        End header arguments affect the results returned by the code
        block.

        ```text
        #+CALL: org_call_test:sayHello(n=5) [:results md]

        #+RESULTS:
        : 5
        ```

<!--list-separator-->

-  Limit code block evaluation

    The `eval` header agruments can limit evaluation of sepcific
    code blocks and `CALL` keyword. It is useful for protection
    against evaluating untrusted code blocks by prompting for a
    confirmation.

    ```text
    #+begin_src emacs-lisp :eval never(no/query/never-export/no-export/query-export)
      (format "%s" (message "hello world"))
    #+end_src
    ```

<!--list-separator-->

-  Cache results of evaluation

    The `cache` header argument is for caching results of evaluating
    code blocks.

    Caching results can avoid re-evaluating a code block that have
    not changed since the previous run.

    The caching feature is best for when code blocks are pure
    functions, that is functions that return the same value for the
    same input arguments.and that do not have side effects, and do
    not rely on external variables other than the input arguments.

    <!--list-separator-->

    -  Environment of a Code Block

        <!--list-separator-->

        -  Passing a default value

            The following syntax is used to pass arguments to code blocks
            using the ‘var’ header argument.

            ```text
            :var NAME=ASSIGN
            ```

            **NAME** is the name of the variable bound in the code block
            body. **ASSIGN** is a literal value, such as a string, a number, a
            reference to a table, a list, a literal example, another code
            block—with or without arguments—or the results of evaluating a
            code block.

            <a id="table--example-table"></a>

            | 1 |
            |---|
            | 2 |
            | 3 |
            | 4 |

            <a id="code-snippet--table-length"></a>
            ```emacs-lisp
            (length table)
            ```

            The **colnames** header argument accepts ‘yes’, ‘no’, or ‘nil’
            values. The default value is ‘nil’:if an input table has
            column names—because the second row is a horizontal rule—then
            Org removes the column names.

            <a id="table--less-cols"></a>

            | a |
            |---|
            | b |
            | c |

            ```python
            return [[val + '*' for val in row] for row in tab]
            ```

            Similarly, the **rownames** header argument can take two values:
            ‘yes’ or ‘no’. When set to ‘yes’, Org removes the first
            column, processes the table, puts back the first column, and
            then writes the table to the results block.

            Note that Emacs Lisp code blocks ignore ‘rownames’ header
            argument because of the ease of table-handling in Emacs.

            <a id="table--with-rownames"></a>

            | "one" | 1 | 2 | 3 | 4 | 5  |
            |-------|---|---|---|---|----|
            | "two" | 6 | 7 | 8 | 9 | 10 |

            ```python
            return [[val + 10 for val in row] for row in tab]
            ```

            **list**

            A simple named list.

            -   simple
                -   not
                -   nested
            -   list

            <!--listend-->

            ```emacs-lisp
            (print x)
            ```

            Note that only the top level list items are passed
            along. Nested list items are ignored.

            A code block name, as assigned by ‘NAME’ keyword from the
            example above, optionally followed by parentheses.

            ```emacs-lisp
            (* 2 length)
            ```

            <a id="code-snippet--double"></a>
            ```emacs-lisp
            (* 2 input)
            ```

            <a id="code-snippet--squared"></a>
            ```emacs-lisp
            (* input input)				; input = 1 替换 double里面的变量
            ```

            **literal example**

            A literal example block named with a ‘NAME’ keyword.

            ```text
            A literal example
            on two lines
            ```

            <a id="code-snippet--read-literal-example"></a>
            ```emacs-lisp
            (concatenate #'string x " for you.")
            ```

            **Indexing variable** values enables referencing portions of a
            variable.

            Note that this indexing occurs before other table-related header
            arguments are applied, such as ‘hlines’, ‘colnames’ and ‘rownames’.

            <a id="table--example-table"></a>

            | 1 | a |
            |---|---|
            | 2 | b |
            | 3 | c |
            | 4 | d |

            ```emacs-lisp
             data
            ```


## Extracting Source Code {#extracting-source-code}

Extracting source code from code blocks is a basic task in literate
programming.Org has features to make this easy.In literate
programming parlance.Documents on creation are woven with code and
documentation,and on export,the code is **tangled** for execution by
a computer.Org facilitates weaving and tangling for
producing,maintaining,sharing,and exporting literate programming
documents.Org provides extensive customization options for
extracting source code.

When org tangles code blocks,it expands,merges,and tramsforms them.
The org recompress them into one or more separate files,as
configured through the options.During this tangling process,Org
expands variables in the source code,and resolves any Noweb style
references.