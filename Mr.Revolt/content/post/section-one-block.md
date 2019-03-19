+++
title = "section-one-block"
author = ["root"]
date = 2019-03-12T00:00:00+08:00
lastmod = 2019-03-15T23:37:32+08:00
tags = ["literary", "programming"]
categories = ["org-mode"]
draft = false
weight = 2001
foo = "bar"
[menu.main]
  identifier = "section-one-block"
+++

## Block {#block}

-   执行本页所有的代码块 `C-c C-v C-b` ,更简单的方式是 `, b b`
-   跳转下一个代码块, `, b n`


### 代码块的基本格式 {#代码块的基本格式}

```nil
#+name: <LABLE>
#+begin_src <LANGUAGE> <HEADER-ARGS>
<BODY>
```


### 设置代码高亮 {#设置代码高亮}

```nil
(setq org-confirm-babel-evaluate nil
      org-src-fontify-natively t
      org-src-tab-acts-natively t)
```


### 测试代码 {#测试代码}

```ruby
Dir.entries('.')

```

```python
from os import listdir
return listdir(".")
```

```sh
ls -l
```


### 代码块的设置 {#代码块的设置}

```sh
ls
```

```sh
hostname -f
```


### 头参数的设置 {#头参数的设置}

```sh
grep $USER passwd
```

```sh
grep $USER passwd
```

```sh
grep $USER passwd
```


### 将头参数添加到标题上 {#将头参数添加到标题上}

-   `, i p` 来设置默认头参数

```ruby
File.absolute_path(".")
```


### Another Section {#another-section}

```sh
ls -d $(pwd)
```

```ruby
File.absolute_path('.')
```


### 制定特定语言的默认头参数 {#制定特定语言的默认头参数}

```sh
ls -d $(pwd)
```


### 为文档内所有的代码块设置默认参数 {#为文档内所有的代码块设置默认参数}


### 头参数的类型 {#头参数的类型}

-   执行类参数
    -   `dir` 这类参数会影响代码块的执行
-   导出类参数
    -   这类参数会把org文件导出成HTML或其他格式的时候,影响代码块以及代码块的执行
-   文学编程类参数
    -   将代码块连接起来,可能会改变实际的源代码
-   变脸类参数
    -   通过不同方式设置代码块中的变脸
-   杂类 输出输入
    -   其他参数


#### results 参数 {#results-参数}

-   如果不加  `:results` 参数,那么返回的将是输出结果.

```ruby
puts 'hello world' ## 代码的返回值
5*6 ## 代码的输出结果
```

-   如果添加 `:results` 参数,那么返回的将是代码的返回值.

```ruby
puts 'hello world' ## 代码的返回值
5*6 ## 代码的输出结果
```


#### 影响输出格式的结果 {#影响输出格式的结果}

代码的执行结果会插入到文档中,它可能以以下几种格式出入.

-   table
    -   如果结果是单个数组,则插入一行,若结果是数组的数组,则插入一个表格.
-   list
    -   按照普通org-mode列表的格式插入一个无序列表
-   verbatim
    -   原样输出
-   file
    -   将结果写入到文件当中
-   html
    -   认为执行的结果是HTML代码,导出时原样导出
-   code
    -   认为执行的结果还是原语言的代码
-   silent
    -   只在 `mini-buffer` 中显示执行的结果


#### 内容测试 {#内容测试}

-    session的例子

    sion 输出成列表

    ```ruby
    Dir.entries('.').sort.select do |file|
      file[0] != '.'
    end
    ```

-    session的例子

    sion 原样输出
     shell 命令和日志输出比较适合使用原样输出

    ```sh
    ssh -v root@23.105.223.211 -p 27653
    ```

-    session的例子

     session
    默认的情况下,每个代码块在每次运行时都会重启自己的一个解释器.

    我们可以通过设置头参数 `:session` 来设置一个标签值,则所有拥有统一标签的代码块在运行时都在同一个解释器Session中.

    之所以这么做事因为,每次重启一个解释器:

    -   有的解释器启动时间很长,像 `clojure`
    -   使用Tramp登录远程机器很慢
    -   代码块共享函数定义与状态

    ```python
    avar = 42
    return avar
    ```

    ```python
    return avar /2
    ```

    此时就会报错.

    如果我们采用一个基于 `:session` 的解释器

    ```python
    a = "hello world"
    print(a)
    ```

    ```python
    a
    ```

    `:session` 常常设置为标题属性,你其实可以切换到 _kill9_ 这个buffer中直接与解释器进行交互.

    可以在那里设置变量以及其他状态,然后在执行代码块.

-    session的例子

    ```sh
    NUM_USERS=$(grep 'bash' /etc/passwd | wc -l --)
    ```

    ```sh
    echo $NUM_USERS
    ```

-    将结果写到文件中

    ```ruby
    require 'prime'
    Prime.each(5000) do |prime|
      p prime
    end
    ```

    此时你会发现执行的结果是插入了一个指向文件的链接,点击该连接会在 `buffer` 中加载该文件.

    注意: `:file` 参数需要与 `:results output` 共用,因为他不知道以哪种格式输出内部值.


### 文学编程 {#文学编程}
