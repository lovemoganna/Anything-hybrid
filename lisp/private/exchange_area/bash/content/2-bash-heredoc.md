+++
title = "BASH Heredoc"
lastmod = 2020-06-20T17:47:08+08:00
draft = false
+++

-**- mode: Org; org-download-image-dir: "~/.emacs.d/lisp/private/gitbook/assets/screenshot/"; -**-

当你写shell脚本的时候你可能会在某个位置传递多行文本块或者代码给一个交
互的命令,比如 `tee` or `cat`, or `sftp`


## Heredoc Syntax {#heredoc-syntax}

```sh
[COMMAND] <<[-] 'DELIMITER'
HERE-DOCUMENT
DELIMITER
```

-   第一行始于一个可选COMMAND,后面跟着特殊的重定向运算符 `<<` 和
    delimiting identifier.
    -   你可以将任何字符串作为 delimiting identifier,最常用的是 `EOF` 和
        `END`.
    -   如果 delimiting identifier 没有引号,在传递 `here-document` 行给
        命令之前,shell会替换所有 variable,command 和 sepcial character.
    -   附加一个 `-` 到重定向运算符 `<<-`, 将会让所有主要的tab字符被忽
        略.当在SHELL脚本里面写 `here-document` 的时候允许你使用
        `indentation` . Leading whitespace characters are not
        allowed,only `tab`.
-   `here-document` 块可以包含 strings, variables, commands 和 其他类
    型的输入.
-   The last line ends with the delimiting identifier.White space in
    front of the delimiter is not allowed.


### Basic Demo {#basic-demo}

```sh
cat <<EOF
The current working directory is: $PWD
You are Logged in as: $(whoami)
EOF
```

此时所有的命令输出和变量输出都会被传递.


### Demo2 {#demo2}

```sh
cat <<- "EOF"
The current working directory is: $PWD
You are Logged in as: $(whoami)
EOF
```

此时所有的命令输出和变量输出不会被传递.


### Demo3 {#demo3}

如果你正在一个statement or loop里面使用 heredoc,使用 `<<-` 重定向
运算符允许你缩进您的代码.

```sh
a=0

cat <<EOF
    $a
EOF
```

在这里你不能使用空格来缩进代码,必须使用TAB来进行缩进,bash里面的TAB
需要按下 `C-v TAB` 来插入.并非简单的 `TAB` 缩进.

reflink: <https://stackoverflow.com/questions/18660798/here-document-gives-unexpected-end-of-file-error>

```sh
#! /bin/bash
if true; then
    cat <<-EOF
	This is a TAB indented.
	EOF
fi
```


### Demo4 {#demo4}

将 heredocument 输出到屏幕的内容重定向到一个文件当中.

```sh
#! /bin/bash
if true; then
    cat <<-EOF > ./test.sh
	This is a TAB indented.
	EOF
fi
```

```sh
cat test.sh
```

```text
This is a TAB indented.
```


### Demo5 {#demo5}

heredocument 的内容与 Pipe 一齐使用.

```sh
cat << 'EOF' | sed 's/l/e/g' > ./file.txt
Hello
World
EOF
```

```sh
cat file.txt
```

```text
Heeeo
Wored
```


### Demo6 {#demo6}

Using Heredoc with SSH:

```sh
ssh -T user@host.com << EOF
echo "The current local working directory is: $PWD"
echo "The current remote working directory is: \$PWD"
EOF
```
