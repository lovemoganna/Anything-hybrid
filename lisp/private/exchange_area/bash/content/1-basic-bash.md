+++
title = "BASH BASIC"
lastmod = 2020-06-17T09:38:58+08:00
draft = false
+++

-**- mode: Org; org-download-image-dir: "~/.emacs.d/lisp/private/gitbook/assets/screenshot/"; -**-


## Getting Bash {#getting-bash}

-   check your current use bash type

    ```shell
    echo $SHELL
    ```

    ```text
    /usr/bin/zsh
    ```

-   check bash path

    ```shell
    whereis bash
    ```

    ```text
    bash: /usr/bin/bash /usr/lib/bash /etc/bash.bashrc /etc/bash.bash_logout /usr/include/bash /usr/share/man/man1/bash.1.gz /usr/share/info/bash.info.gz
    ```

    ```shell
    which bash
    ```

    ```text
    /usr/bin/bash
    ```

    ```shell
    whence bash
    ```

    ```text
    /usr/bin/bash
    ```

-   change current defualt shell

    ```shell
    # chsh /usr/bin/bash
    ```


## Interactive Shell Use {#interactive-shell-use}


### Commands,Arguments,and Options {#commands-arguments-and-options}

Shell 命令行有一个或者多个word组成,通过BLANKS或者TABS来进行分隔.组
成格式如下:

```text
command auguments/parameters
```


### Files {#files}

File是任何UNIX系统中最重要的类型.一个File可以包含各种各样的信息,同
样也有不同类型的File.主要有三种最重要的类型:

Regular files(常规文件)
: text files.


Executable files(可执行文件)
: The shell itself is a executable
    file called _bash_.


Directories(目录)
: like folders that contain other files.


### Directories {#directories}

Directories can contain other directories leads to a hierachical structure.

<html>
  <body>
    <div style="text-align: center">
      <img src="https://i.imgur.com/xraNY0O.png" alt="directory tree"
	   style="width:300px;height=300px;display: inline-block;"/>
      <p>directories tree</p>
    </div>
  <body/>
</html>


### The working directory {#the-working-directory}

You need to specify a file path,then you should have a work
directory,then should use _relative path_.

When you log in to the system,your working directory is initially
set to a special directory called your _home_ directory.

系统管理员经常设置系统,所有每个人的HOME目录名字都跟他们的登录名字
相同,所有的HOME目录都被包含在root之下的同一个目录内.


### Tilde notation (~) {#tilde-notation}

1.run `org-babel-tangle` generate `hello.txt` file in `/home/revolt`
(your user ditrectory).

```shell
结婚没意思
```

2.你可以在用户 `revolt` HOME 目录下引用一个file `hello`.写法如下:

```shell
#!/bin/bash
ls -ll ~revolt/hello.txt
```

```text
-rw-r--r-- 1 root root 16 Jun 17 09:38 /home/revolt/hello.txt
```

这是一种绝对路径,当你使用它的时候,你不必在乎它的working directory.

更加方便的是, `~` 本身就是引用到你自己的 `home` 目录.

```shell
#!/bin/bash
ls -ll ~/
```

```shell
#!/bin/bash
ls -ll /home/revolt
```

注意下 `~hello.txt` 与 `~/hello.txt` 的区别.

```text
[revolt@Remake ~]$ cat ~revolt/hello.txt
结婚没意思
[revolt@Remake ~]$ cat ~/hello.txt
结婚没意思
[revolt@Remake ~]$ cat ~hello.txt
cat: '~hello.txt': No such file or directory

# in here, ~hello.txt is user hello.txt's home directory.
```


### Changing working directories {#changing-working-directories}

Just input `cd` in terminal, you will go to your home directory.


### Filenames,Wildcards,and Pathname Expansion {#filenames-wildcards-and-pathname-expansion}

| Wildcard | Matches                  |
|----------|--------------------------|
| ?        | Any Single Character     |
| \*       | Any String of Character  |
| [set]    | Any character in set     |
| [!set]   | Any character not in set |

```shell
ls hello????
```

```text
hello.asd
hello.txt
```

```shell
ls hello*
```

```text
hello.asd
hello.txt
```

```text
Remake➜  test : master ✘ :✖✹✭ ᐅ  ls -al
total 20
drwxr-xr-x  5 revolt revolt 4096 Jun 15 23:11 .
drwxr-xr-x 12 revolt revolt 4096 Jun 15 21:41 ..
drwxr-xr-x  2 revolt revolt 4096 Jun 15 19:41 bash
drwxr-xr-x  2 revolt revolt 4096 Jun 15 23:11 cash
drwxr-xr-x  3 revolt revolt 4096 Jun 15 17:54 pweave_demo

Remake➜  test : master ✘ :✖✹✭ ᐅ  tree [bc]ash   # here test demo
bash
├── 1.txt
├── file.err
└── file.out
cash

0 directories, 3 files
Remake➜  test : master ✘ :✖✹✭ ᐅ

```

```shell
echo {a,b,c{a,c,d}}
```

```text
a b ca cc cd
```


### Pipelines {#pipelines}

需要弄清楚,

1.何时需要把结果输出到一个文件里?

2.何时需要重定向 一个命令的输出 作为 其他命令的输入?

2描述的这种操作可以称为 pipe.(管道),本质上是个传递操作,符号记做
`|`.

比如: 在使用 `ls -l` 的时候,如果你的文件太多,还没来得及一一浏览,就
一闪而过了.此时,你可以使用 `ls -ll | more` 来进行预览.

The file `/etc/passwd` stores information about user's accounts on
a UNIX system.

main have login name,user ID number,encryted passwd,home
directory,login shell.

```sh
bat /etc/passwd
```

想得到当前系统经过排序的所有用户,

```sh
# cut command extracts the first field (-f1)
cut -d: -f1 < /etc/passwd | sort
```

```text
avahi
bin
colord
cups
daemon
dbus
dhcpcd
ftp
git
http
mail
mysql
nobody
ntp
nvidia-persistenced
polkitd
revolt
root
rtkit
sddm
systemd-coredump
systemd-journal-remote
systemd-network
systemd-resolve
systemd-timesync
tor
usbmux
uuidd
```


#### cut command {#cut-command}

```sh
cut --help
```

generate a test file `demo1.txt`

```bash
No;Name;Mark;Percent
01 tom 69 91
02 jack 71 87
03 alex 68 98
```

现在我们想选出 `demo1.txt` 中的第一行的 `Name;Mark` 字段.

1.我们第一步清洗出带有 `Name;Mark` 的所有字段.

```sh
#! /bin/bash
cut -d ";" -f 2,3 demo1.txt
# cut -d ";" -f 2- demo1.txt # print the second field to end of line

# ref link: https://www.jianshu.com/p/b5541da98139
```

2.利用stream editor选出第一行,管道操作一下.

```sh
#! /bin/bash
sed -n "1p" demo1.txt | cut -d ";" -f 1,2

# print line 1 to end of line
# sed -n '2,$p' demo1.txt # 注意这里一定要使用单引号

# ref link: https://blog.csdn.net/lantianjialiang/article/details/52042135
```
