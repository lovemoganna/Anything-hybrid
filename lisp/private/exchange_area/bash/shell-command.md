# Shell Command #

## Pipelines ##

一个 `pipeline` 是一个或者多个通过控制运算符 `|` or `|&` 分开的序列.

`pipeline` 的格式如下:

  ```sh
  [time [-p]] [!] command1 [ | or |& command2 ] ...
  ```

在pipeline中每个命令的输出通过管道被关联到下一个命令的输入.每个命令读
取上一个命令的输出.这个连接会在命令指定任何重定向之前会被执行.

如果 `|&` 被用过了, `command1`的标准error,会附加到它标准输出上去,通过
这个管道连接到 `command2` 的标准输入. 它是 `2>&1 |` 的简写. 标准
error 到标准 output 的隐式重定向会在命令指定任何重定向之后被执行.

传输管道一旦完成,保留字 `time` 时间统计就会被打印.统计当前包括(挂钟)
时间,用户,系统时间通过命令执行消耗的时间. `-p` 选项改变输出为POSIX指
定的格式.当SHELL是 `POSIX mode` 的时候,如果下一个 token 以 `a` 开头,
它将不会将 `time` 视为保留字. `TIMEFORMAT` 变量可能会设置一个格式字符
串来指定 timing 信息如何被展示. `bash variable` 里有更加详细的描述.允
许SHELL内置,shell函数,管道的计时使用`time` 作为保留字,外部的`time` 命
令不会轻易的计时.

当SHELL处于POSIX MODE的时候, `time` 后面可能会带着换行符.在这种情况
下,SHELL通过shell和它的children展示整个user和system消耗的时间.
`TIMEFORMAT` 变量被用来指定 time information的格式.

如果管道不是asynchronously执行,shell会等着管道里所有命令执行完毕.

管道里的每个命令会在它自己的subshell被执行,这是一个分离的过程,如果
`lastpipe`选项使用内置命令`shopt`开启,管道的最后的一个元素可以由shell
进程运行.

除非`pipefail` 被开启.管道的 `exit status` 是管道中最后一个命令的
`exit status`.如果`pipefail`是开启状态,管道的返回状态是最后(最右侧)命
令以非零状态退出的值,如果所有命令退出成功,管道的返回状态就是0.如果保留
字 `!` 先于管道之前, `exit status` 与上面 `exit status`描述相反.shell
等着管道中的所有命令在返回值之前终止.


**More Information**

```markdown
shell脚本中,默认情况下,总是有三个文件处于打开状态,分别是:

- 标准输入 (默认键盘输入,文件描述符为0)
- 标准输出 (默认屏幕输出,文件描述符为1)
- 标准错误 (默认屏幕输出,文件描述符为2)

> 默认为标准输出重定向,与 1> 相同.
2>&1 将标准错误输出重定向到标准输.
&>file 将标准输出和标准错误输出都重定向文件file当中.
/dev/null是一个文件,所有传递给它的文件都会被丢弃掉.
```

**TEXT DEMO**

Welcome to plain text world!

Scene: 当前目录只有一个文件 a.txt

1.测试 1 and 2 输出

```text
[revolt@Remake ~]$ ls a.txt b.txt
ls: cannot access 'b.txt': No such file or directory
a.txt
```
由于没有 b.txt 这个文件,所以就会返回错误值.也就是标准错误输出(2输出).
a.txt 由于存在,所以就是标准输出(1输出).

![stand_optout_and_stand_error](https://i.imgur.com/eieGegX.png =50x20) 

2.理解 "1>&2" 和 "2>&1"

所谓 `1>` 可以简写成为 `>`. 所以可以简写成为 

![Imgur](https://i.imgur.com/y513HIB.png)

**1>&2 正确返回值传递给2输出通道, &2表示2输出通道.**

**2>&1 错误返回值传递给1输出通道, &1表示1输出通道.**

2.1 测试错误返回值传递

![Imgur](https://i.imgur.com/6PXbhMg.png)

此时将错误返回值,通过2标准错误输出 传递到 1标准输出里.

2.2 直接将正确和错误的返回值都写到文件当中

![Imgur](https://i.imgur.com/6PXbhMg.png)











