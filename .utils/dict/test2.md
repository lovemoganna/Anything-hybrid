# 4 Parameters

Parameters are a sort of named space in memory you can use to retrieve
or store information. Generally speaking, they will store string data,
but can also be used to store integers, indexed and associative
arrays.

＃4参数

参数是内存中的一种命名空间，可用于检索
或存储信息。一般来说，它们将存储字符串数据，
但也可以用于存储整数，索引的和关联的
数组。

Parameters come in two flavors: variables and special
parameters. Special parameters are read-only, pre-set by BASH,and used
to communicate some type of internal status. Variables are parameters
that you can create and update yourself.

参数有两种形式：变量和特殊
参数。特殊参数是只读的，由BASH预先设置，并已使用
传达某种内部状态。变量是参数
您可以创建和更新自己。

Variable names are bound by the following rule:

变量名称受以下规则约束：

- Name: A word consisting only of letters, digits and underscores, and
  beginning with a letter or an underscore. Also referred to as an
  identifier.

-名称：仅由字母，数字和下划线组成的单词，以及
  以字母或下划线开头。也称为
  标识符。
  
To store data in a variable, we use the following assignment syntax:

-名称：仅由字母，数字和下划线组成的单词，以及
  以字母或下划线开头。也称为
  标识符。

``` bash
$ varname=vardata
```

bash
$ varname = vardata
```

This command assigns the datavardatato the variable by name ofvarname.
Please note that youcannotuse spaces around the=sign in an
assignment. If you write this:

此命令通过名称varname将数据vardata分配给变量。
请注意，您不能在=
分配。如果您这样写：

``` bash

bash
# This is wrong!
$ varname = vardata
```

重击

BASH^1 will not know that you are attempting to assign something. The
parser will seevarnamewith no=and treat it as a command name, and then
pass=andvardatato it as arguments.

BASH ^ 1不会知道您正在尝试分配某些内容。的
解析器将看到带有no =的varname并将其视为命令名称，然后
通过=和vardata作为参数。

To access the data stored in a variable, we use parameter
expansion. Parameter expansion is thesubstitutionof a parameter by its
value, which is to say, the syntax tells bash that you want to use the
contents of the variable. After that, Bashmay still perform additional
manipulations on the result. This is a very important concept to grasp
correctly, because it is very much unlike the way variables are
handled in other programming languages!

要访问存储在变量中的数据，我们使用参数
扩张。参数扩展是参数被其替换
值，也就是说，语法告诉bash您要使用
变量的内容。之后，Bash可能仍会执行其他操作
对结果的操纵。这是一个非常重要的概念
正确，因为它与变量的方式非常不同
用其他编程语言处理！

To illustrate what parameter expansion is, let’s use this example:

为了说明什么是参数扩展，让我们使用以下示例：

```
$ foo=bar
$ echo "Foo is $foo"
```

```
$ foo = bar
$ echo“ Foo是$ foo”
```

When Bash is about to execute your code, it first changes the command
by taking your parameter expansion (the$foo), and replacing it by the
contents offoo, which isbar. The command becomes:

当Bash即将执行您的代码时，它首先更改命令
通过执行参数扩展（the $ foo），然后将其替换为
foo的内容，即isbar。命令变为：

```
$ echo "Foo is bar"
Foo is bar
```

```
$ echo“ Foo is bar”
Foo是酒吧
```

Now, Bash is ready to execute the command. Executing it shows us the
simple sentence on screen.

现在，Bash准备执行命令。执行它向我们展示了
屏幕上的简单句子。

It is important to understand that parameter expansion causes
the$parameterto bereplacedby its contents. Note the following case,
which relies on an understanding of the previous chapter on argument
splitting:

重要的是要了解参数扩展会导致
$参数将由其内容代替。请注意以下情况，
依靠对上一章论点的理解
分裂：

```
$ song="My song.mp3"
$ rm $song
rm: My: No such file or directory
rm: song.mp3: No such file or directory
```

```
$ song =“ My song.mp3”
$ rm $歌曲
rm：我的：没有这样的文件或目录
rm：song.mp3：没有这样的文件或目录
```

(^1)
[http://mywiki.wooledge.org/BASH](http://mywiki.wooledge.org/BASH)

（^ 1）
[http://mywiki.wooledge.org/BASH](http://mywiki.wooledge.org/BASH）


Why did this not work? Because Bash replaced your$songby its contents,
beingMy song.mp3; then it performed word splitting; and only THEN
executed the command. It was as if you had typed this:

为什么这不起作用？由于Bash用其内容替换了您的歌曲，
是我的song.mp3;然后执行分词；然后只有
执行命令。好像您输入了以下内容：

```
$ rm My song.mp3
```

```
$ rm我的song.mp3
```

And according to the rules of word splitting, Bash thought you meant
forMyandsong.mp3to mean two different files, because there is white
space between them and it wasn’t quoted. How do we fix this? We
remember toput double quotes around every parameter expansion!

根据分词规则，Bash认为您的意思是
forMyandsong.mp3表示两个不同的文件，因为有白色
它们之间没有空格，也没有引用。我们该如何解决？我们
切记在每个参数扩展周围加上双引号！


- Parameters: Parameters store data that can be retrieved through a
  symbol or a name.

-参数：参数存储可通过以下方式检索的数据：
  符号或名称。
  

### 4.1 Special Parameters and Variables

Let’s get our vocabulary straight before we get into the real
deal. There areParametersandVariables. Variables are actually just one
kind of parameter: parameters that are denoted by a name. Parameters
that aren’t variables are called Special Parameters. I’m sure you’ll
understand things better with a few examples:

### 4.1特殊参数和变量

让我们先掌握词汇表，然后再进入真正的
处理。有参数和变量。变量实际上只是一个
参数的种类：以名称表示的参数。参量
不是变量的称为特殊参数。我确定你会
通过一些示例更好地理解事情：

```
$ # Some parameters that aren't variables:
$ echo "My shell is $0, and has these options set: $-"
My shell is -bash, and has these options set: himB
$ # Some parameters that ARE variables:
$ echo "I am $LOGNAME, and I live at $HOME."
I am lhunath, and I live at /home/lhunath.
```
Please note: Unlike PHP /Perl/... parameters do NOT start with a
$-sign. The $-sign you see in the examples merely causes
the parameter that follows it to beexpanded. Expansion basically means
that the shell replaces the parameter by its content.

```
$＃一些不是变量的参数：
$ echo“我的shell是$ 0，并且设置了以下选项：$-”
我的shell是-bash，并设置了以下选项：himB
$＃是变量的一些参数：
$ echo“我是$ LOGNAME，我住在$ HOME。”
我是lhunath，我住在/ home / lhunath。
```
请注意：与PHP / Perl / ...不同，参数不要以
$符号。您在示例中看到的$符号只是导致
紧随其后的参数。扩张基本上意味着
shell用其内容替换参数。

As such,LOGNAMEis the parameter (variable) that contains your
username.$LOGNAMEis an expression that will be replaced with the
content of that variable, which in my case is lhunath.  I think you’ve
got the drift now. Here’s a summary of most of the Special Parameters:

因此，LOGNAME是包含您的
username。$ LOGNAME是一个表达式，将被替换为
该变量的内容，在我的例子中是lhunath。我想你已经
现在得到了漂移。以下是大多数特殊参数的摘要：


```
Parameter Name Usage Description
0 "$0"
Contains the name, or the path, of the
script. This is not always reliable.
```

```
参数名称用法说明
0“ $ 0”
包含名称或路径
脚本。这并不总是可靠的。
```

```
1 2etc. "$1"etc.
```

```
1 2等“ $ 1”等
```

```
Positional Parameterscontain the
arguments that were passed to the
current script or function.
```

```
位置参数包含
传递给
当前脚本或函数。
```
##### * "$*"

```
Expands to all the words of all the
positional parameters. Double
quoted, it expands to a single string
containing them all, separated by the
first character of theIFSvariable
(discussed later).
```

```
扩展到所有
位置参数。双
用引号引起来，它扩展为单个字符串
包含所有内容，并以
IFS变量的第一个字符
（稍后讨论）。
```

##### @ "$@"

```
Expands to all the words of all the
positional parameters. Double
quoted, it expands to a list of them all
as individual words.
```

```
扩展到所有
位置参数。双
用引号引起来，它扩展为一对双重
包含所有内容，并以
IFS变量的第一个字符
（稍后讨论）。
```
# $#
Expands to the number of positional parameters that are currently set.

```
扩展到所有
位置参数。双
用引号引起来，它扩展为一对双重
包含所有内容，并以
IFS变量的第一个字符
（稍后讨论）。
```

? $?

？ $？

```
Expands to the exit code of the most
recently completed foreground
command.
```
$ $$
Expands to the PID^1 (process ID
number) of the current shell.

```
扩展到最大的退出代码
最近完成的前景
命令。
```
$ $$
扩展为PID ^ 1（进程ID
当前shell的数字）。

! $!

！ $！

```
Expands to the PID of the command
most recently executed in the
background.
```
_ "$_"
Expands to the last argument of the
last command that was executed.

```
扩展为命令的PID
最近在
背景。
```
_“ $ _”
扩展到的最后一个参数
最后执行的命令。

```
And here are a few examples ofVariablesthat the shell provides for you:
```

```
以下是Shell为您提供的一些变量示例：
```
- BASH_VERSION: Contains a string describing the version of Bash.

- HOSTNAME: Contains the hostname of your computer, I swear. Either
  short or long form, depending on how your computer is set up.

-HOSTNAME：我发誓，它包含您计算机的主机名。要么
  短格式或长格式，取决于计算机的设置方式。
  
- PPID: Contains the PID of the parent process of this shell.

-PPID：包含此Shell的父进程的PID。

- PWD: Contains the current working directory.

-PWD：包含当前工作目录。

- RANDOM: Each time you expand this variable, a (pseudo)random number
  between 0 and 32767 is generated.

-RANDOM：每次扩展此变量时，都会（伪）随机数
  生成介于0和32767之间的值。
  
- UID: The ID number of the current user. Not reliable for
  security/authentication purposes, alas.

-UID：当前用户的ID号。不可靠
  安全/身份验证目的，las。
  
- COLUMNS: The number of characters that fit on one line in your
  terminal. (The width of your terminal in characters.)

-栏：您的一行中适合的字符数
  终奌站。 （终端的宽度，以字符为单位。）
  
- LINES: The number of lines that fit in your terminal. (The height of
  your terminal in characters.)

-线数：适合您终端的线数。 （高度
  您的终端字符）。
  
- HOME: The current user’s home directory.

-HOME：当前用户的主目录。
- PATH: A colon-separated list of paths that will be searched to find
  a command, if it is not an alias, function, builtin command, or
  shell keyword, and no pathname is specified.

-路径：用冒号分隔的路径列表，将通过搜索找到该路径
  命令，如果它不是别名，函数，内置命令或
  shell关键字，未指定路径名。
- PS1: Contains a string that describes the format of your shell
  prompt.

-PS1：包含描述您的Shell格式的字符串
  提示。
- TMPDIR: Contains the directory that is used to store temporary files
  (by the shell).

-TMPDIR：包含用于存储临时文件的目录
  （通过外壳）。

(^1)
[http://mywiki.wooledge.org/ProcessManagement](http://mywiki.wooledge.org/ProcessManagement)

（^ 1）
[http://mywiki.wooledge.org/ProcessManagement](http://mywiki.wooledge.org/ProcessManagement）


(There are many more -- see the manual for a comprehensive list.) Of
course, you aren’t restricted to only these variables.

（还有更多内容-有关详细列表，请参见手册。）
当然，您不仅限于这些变量。

Feel free to define your own:

随意定义自己的：

```
$ country=Canada
$ echo "I am $LOGNAME and I currently live in $country."
I am lhunath and I currently live in Canada.
```

```
$ country =加拿大
$ echo“我是$ LOGNAME，目前居住在$ country。”
我是lhunath，目前住在加拿大。
```

Notice what we did to assign the valueCanadato the
variablecountry. Remember that you areNOT allowed to have any spaces
before or after that equals sign!

注意我们将valueCanada分配给
可变国家。请记住，您不允许有任何空格
在等号之前或之后！

```
$ language = PHP
-bash: language: command not found
$ language=PHP
$ echo "I'm far too used to $language."
I'm far too used to PHP.
```

```
$语言= PHP
-bash：语言：找不到命令
$ language = PHP
$ echo“我太习惯了$语言。”
我也很习惯PHP。
```

Remember that Bash is not Perl or PHP. You need to be very well aware
of howexpansionworks to avoidbigtrouble. If you don’t, you’ll end up
creating very dangerous situations in your scripts, especially when
making this mistake with rm:

请记住，Bash不是Perl或PHP。您需要非常清楚
如何避免大麻烦。如果没有，最终
在脚本中造成非常危险的情况，尤其是当
用rm犯这个错误：

```
$ ls
no secret secret
$ file='no secret'
$ rm $file
rm: cannot remove`no': No such file or directory
```

```
$ ls
没有秘密的秘密
$ file ='没有秘密'
$ rm $文件
rm：无法删除`no'：没有这样的文件或目录
```

Imagine we have two files,no secretandsecret. The first contains
nothing useful, but the second contains the secret

想象我们有两个文件，没有秘密和秘密。第一个包含
没有什么用，但是第二个包含了秘密

that will save the world from impending doom. Unthoughtful as you are,
you forgot toquoteyour parameter expansion of file. Bash expands the
parameter and the result isrm no secret. Bash splits the arguments up
by their whitespace as it normally does, and rm is passed two
arguments: ’no’ and ’secret’. As a result, it fail to find the
filenoand it deletes the file secret.The secret is lost!

这将使世界免于即将来临的厄运。不管你是多么体贴
您忘记了引用文件的参数扩展。 Bash扩展了
参数和结果isrm没有秘密。 Bash分解了论点
像平常一样用空格隔开，并且rm传递两个
论点：“否”和“秘密”。结果，它找不到
fileno并删除文件密码。密码丢失！



- Good Practice: You should always keep parameter expansions properly
  quoted. This prevents the whitespace or the possible globs inside of
  them from giving you gray hair or unexpectedly wiping stuff off your
  computer. The only good PE, is a quoted PE.

-良好做法：您应始终正确保留参数扩展
  引。这样可以防止空格或内部可能出现的问题
  从他们给你白发或意外擦掉你的东西
  电脑。唯一好的PE是报价PE。
- In The Manual: Shell Parameters^1 , Shell Variables^2
- In the FAQ: How can I concatenate two variables? How do I append a
	string to a variable?^3 How can I access positional parameters
	after $9?^4

-在常见问题解答中：如何连接两个变量？我如何附加一个
字符串到变量？^ 3如何访问位置参数
在$ 9之后？^ 4

 1. [http://www.gnu.org/software/bash/manual/bashref.html#Shell-Parameters](http://www.gnu.org/software/bash/manual/bashref.html#Shell-Parameters)

1. [http://www.gnu.org/software/bash/manual/bashref.html#Shell-Parameters](http://www.gnu.org/software/bash/manual/bashref.html#Shell-参数）
 
2. [http://www.gnu.org/software/bash/manual/bashref.html#Shell-Variables](http://www.gnu.org/software/bash/manual/bashref.html#Shell-Variables)

2. [http://www.gnu.org/software/bash/manual/bashref.html#Shell-Variables](http://www.gnu.org/software/bash/manual/bashref.html#Shell-变量）
3. [http://mywiki.wooledge.org/BashFAQ/013](http://mywiki.wooledge.org/BashFAQ/013)
4. [http://mywiki.wooledge.org/BashFAQ/025](http://mywiki.wooledge.org/BashFAQ/025)

4. [http://mywiki.wooledge.org/BashFAQ/025](http://mywiki.wooledge.org/BashFAQ/025）


- Variable: A variable is a kind of parameter that you can create and
  modify directly. It is denoted by a name, which must begin with a
  letter or underscore (_), and must consist only of letters, digits,
  and the underscore. Variable names are case-sensitive.

-变量：变量是一种可以创建的参数，
  直接修改。用名称表示，该名称必须以
  字母或下划线（_），并且只能包含字母，数字，
  和下划线。变量名称区分大小写。
  
- Expansion: Expansion happens when a parameter is prefixed by a
  dollar sign. Bash takes the parameter’s value and replaces the
  parameter’s expansion by its value before executing the
  command. This is also called substitution.

-扩展：当参数以开头时，会发生扩展
  美元符号。 Bash将参数的值替换为
  参数在执行之前按其值扩展
  命令。这也称为替代。

### 4.2 Variable Types

Although Bash is not a typed language, it does have a few different
types of variables. These types define the kind of content they are
allowed to have. Type information is stored internally by Bash.

-扩展：当参数以初期时，会发生扩展
  美元符号。Bash将参数的值替换为
  参数在执行之前按其值扩展
  命令。这也称为替代。


- Array:declare -a variable: The variable is an array of strings.

-数组：声明-a变量：该变量是字符串数组。
- Associative array:declare -A variable: The variable is an
  associative array of strings (bash 4.0 or higher).

-关联数组：声明-A变量：该变量是
  字符串关联数组（bash 4.0或更高版本）。
- Integer: declare -i variable: The variable holds an
  integer. Assigning values to this variable automatically triggers
  Arithmetic Evaluation.

-整数：声明-i变量：该变量包含一个
  整数。给该变量赋值会自动触发
  算术评估。
- Read Only:declare -r variable: The variable can no longer be
  modified or unset.

-只读：声明-r变量：该变量不再是
  修改或未设置。
- Export:declare -x variable: The variable is marked for export which
  means it will be inherited by any child process.

-导出：声明-x变量：该变量标记为要导出的变量
  表示它将被任何子进程继承。

Arrays are basically indexed lists of strings. They are very
convenient for their ability to store multiple strings together
without relying on adelimiterto split them apart (which is tedious
when done correctly and error-prone when not).

数组基本上是索引的字符串列表。他们很
方便将它们存储在一起
无需依靠adelimiter将它们分开（这很繁琐）
如果操作正确，则容易出错）。

Defining variables as integers has the advantage that you can leave
out some syntax when trying to assign or modify them:

将变量定义为整数具有可以离开的优点
尝试分配或修改它们时，列出一些语法：

``` bash
$ a=5; a+=2; echo "$a"; unset a
52
$ a=5; let a+=2; echo "$a"; unset a
7
$ declare -i a=5; a+=2; echo "$a"; unset a
7
$ a=5+2; echo "$a"; unset a
5+2
$ declare -i a=5+2; echo "$a"; unset a
7
```

bash
$ a = 5; a + = 2;回显“ $ a”；取消设定
52
$ a = 5;让a + = 2;回显“ $ a”；取消设定
7
$声明-i a = 5; a + = 2;回显“ $ a”；取消设定
7
$ a = 5 + 2;回显“ $ a”；取消设定
5 + 2
$声明-i a = 5 + 2;回显“ $ a”；取消设定
7
```

However, in practice the use ofdeclare -iis exceedingly rare. In large
part, this is because it creates behavior that can be surprising to
anyone trying to maintain the script, who misses the declare
statement. Most experienced shell scripters prefer to use explicit
arithmetic commands (with((...))orlet) when they want to perform
arithmetic.

但是，实际上，很少使用声明-ii。很大
部分是因为它产生的行为可能令
任何试图维护脚本的人都错过了声明
声明。大多数经验丰富的Shell脚本编写者都喜欢使用显式
要执行的算术命令（with（（...））orlet）
算术。

It is also rare to see an explicit declaration of an array using
declare -a. It is sufficient to write array=(...)  and Bash will know
that the variable is now an array. The exception to this is the
associative array, whichmustbe declared explicitly:declare -A my
array.

也很少见到使用
声明-a。写array =（...）就足够了，Bash会知道
现在该变量是一个数组。例外是
关联数组，必须明确声明：declare -A my
数组。

- String: A string is a sequence of characters.

-字符串：字符串是字符序列。
- Array: An array is a list of strings indexed by numbers.
- Integer: An integer is a whole number (positive, negative or zero).

-整数：整数是整数（正数，负数或零）。
- Read Only: Parameters that are read-only cannot be modified or
  unset.

-只读：只读参数无法修改或
  未设定。
- Export: Variables that are marked for export will be inherited by
  any child process. Variables inherited in this way are called
  Environment Variables.

-导出：标记为导出的变量将被继承
  任何子进程。以这种方式继承的变量称为
  环境变量。
- In the FAQ: How can I use array variables?^1

### 4.3 Parameter Expansion

Parameter Expansionis the term that refers to any operation that
causes a parameter to be expanded (replaced by content). In its most
basic appearance, the expansion of a parameter is achieved by
prefixing that parameter with a$sign. In certain situations,
additional curly braces around the parameter’s name are required:

### 4.3参数扩展

参数扩展是指涉及以下任何操作的术语：
导致参数被扩展（由内容替换）。在最
基本外观，参数的扩展是通过
给该参数加上$符号前缀。在某些情况下，
需要在参数名称周围加上花括号：

``` bash
$ echo "'$USER', '$USERs', '${USER}s'"
'lhunath', '', 'lhunaths'
```
This example illustrates what basic parameter expansions (PE) look
like. The second PE results in an empty string. That’s because the
parameterUSERsis empty. We did not intend to have the sbe part of the
parameter name. Since there’s no way Bash could know you want a
literals appended to the parameter’s value, you need to use curly
braces to mark the beginning and end of the parameter name. That’s
what we do in the third PE in our example above.

bash
$ echo“'$ USER'，'$ USERs'，'$ {USER} s'”
'lhunath'，''，'lhunaths'
```
本示例说明了基本参数扩展（PE）的外观
喜欢。第二个PE导致一个空字符串。那是因为
parameterUSERsis为空。我们不打算将sbe纳入
参数名称。由于Bash不可能知道您想要一个
参数值后面附加的文字，您需要使用curl
用大括号标记参数名称的开头和结尾。那是
在上面的示例中，我们在第三次PE中所做的操作。

Parameter Expansion also gives us tricks to modify the string that
will be expanded. These operations can be terribly convenient:

参数扩展还为我们提供了修改字符串的技巧
将扩大。这些操作非常方便：

```
$ for file in*.JPG*.jpeg
do mv -- "$file" "${file%.*}.jpg"
done
```

```
$用于* .JPG * .jpeg中的文件
做MV-“ $ file”“ $ {file％。*}。jpg”
完成
```

The code above can be used to rename all JPEG files with a.JPGor
a.jpeg extension to have a normal.jpg extension.

上面的代码可用于使用a.JPGor重命名所有JPEG文件
a.jpeg扩展名具有normal.jpg扩展名。

The expression${file%.*}cuts off everything from the end starting with
the last period (.). Then, in the same quotes, a new extension is
appended to the expansion result.

表达式$ {file％。*}从结尾处切断所有内容
最后一个时期（。）。然后，用相同的引号将新扩展名
附加到扩展结果中。

Here’s a summary of most of the PE tricks that are available:

以下是大多数可用的PE技巧的摘要：

(^1)
[http://mywiki.wooledge.org/BashFAQ/005](http://mywiki.wooledge.org/BashFAQ/005)

（^ 1）
[http://mywiki.wooledge.org/BashFAQ/005](http://mywiki.wooledge.org/BashFAQ/005）


Syntax Description:

语法说明：

``` bash
${parameter:-word}
```

bash
$ {参数：-word}
```

Use Default Value. If ’parameter’ is unset or null, ’word’ (which may
be an expansion) is substituted.  Otherwise, the value of ’parameter’
is substituted.

使用默认值。如果未设置或设置为“参数”，则为“单词”（可能
被扩展）替换。否则，“参数”的值
被取代。

```
${parameter:=word}
```

```
$ {parameter：= word}
```

Assign Default Value. If ’parameter’ is unset or null,
’word’ (which may be an expansion) is assigned to
’parameter’. The value of ’parameter’ is then
substituted.
```
${parameter:+word}

分配默认值。如果未设置“参数”或为空，
“单词”（可能是扩展名）已分配给
'参数'。则“ parameter”的值为
替代。
```
$ {parameter：+ word}

``` Use Alternate Value. If ’parameter'is null or unset, nothing is
substituted, otherwise ’word’ (which may be an expansion) is
substituted.

使用替代值。如果“参数”为空或未设置，则没有任何内容
被替换，否则“单词”（可能是扩展名）为
替代。

```
${parameter:offset:length}
```

```
$ {parameter：offset：length}
```

Substring Expansion. Expands to up to ’length’
characters of ’parameter’ starting at the character
specified by ’offset’ (0-indexed). If ’:length’ is
omitted, go all the way to the end. If ’offset’ is
negative (use parentheses!), count backward from the end
of ’parameter’ instead of forward from the beginning.
If ’parameter’ is @ or an indexed array name
subscripted by @ or *, the result is ’length’ positional
parameters or members of the array, respectively, starting
from ’offset’.

子串扩展。扩展到“长度”
“ parameter”的字符从字符开始
由“偏移”（0索引）指定。如果“：length”为
省略，一直到最后。如果“偏移量”为
负数（使用括号！），从末尾开始倒数
而不是从头开始。
如果“参数”为@或索引数组名称
用@或*下标，结果是“长度”位置
分别从数组的参数或成员开始
从“偏移”开始

```
${#parameter}
```

```
$ {＃parameter}
```

The length in characters of the value of ’parameter’ is
substituted. If ’parameter’ is an array name
subscripted by @ or *, return the number of elements.

“参数”值的字符长度为
替代。如果“参数”是数组名称
用@或*下标，返回元素数。

```
${parameter#pattern}
```

```
$ {parameter＃pattern}
```

The ’pattern’ is matched against thebeginningof
’parameter’. The result is the expanded value of
’parameter’ with the shortest match deleted.
If ’parameter’ is an array name subscripted by @ or *,
this will be done on each element. Same for all following
items.

“样式”与开头的匹配
'参数'。结果是的扩展值
匹配最短的“参数”已删除。
如果“参数”是用@或*下标的数组名称，
这将在每个元素上完成。以下所有内容均相同
项目。

${parameter##pattern} As above, but thelongestmatch is deleted.

$ {parameter ## pattern}如上所述，但最长匹配被删除。

```
${parameter%pattern}
```

```
$ {parameter％pattern}
```

The ’pattern’ is matched against theendof
’parameter’. The result is the expanded value of
’parameter’ with the shortest match deleted.
${parameter%%pattern} As above, but thelongestmatch is deleted.

“模式”与结尾匹配
'参数'。结果是的扩展值
匹配最短的“参数”已删除。
$ {parameter %% pattern}如上所述，但最长匹配被删除。

```
${parameter/pat/string}
```

```
$ {parameter / pat / string}
```

Results in the expanded value of ’parameter’ with the
first(unanchored) match of ’pat’ replaced by
’string’. Assume null string when the ’/string’ part
is absent.
${parameter//pat/string} As above, buteverymatch of ’pat’ is replaced.

结果是“参数”的扩展值与
“ pat”的第一个（固定）匹配项替换为
'串'。假设“ / string”部分为空字符串
缺席。
$ {parameter // pat / string}如上所述，替换了所有“ pat”匹配项。

``` ${parameter/#pat/string} ```

```$ {parameter /＃pat / string}```

As above, but matched against thebeginning. Useful for
adding a common prefix with a null pattern:
"${array[@]/#/prefix}".
${parameter/%pat/string}
As above, but matched against theend. Useful for adding
a common suffix with a null pattern.

如上，但与开头相匹配。对...有用
添加带有空模式的通用前缀：
“ $ {array [@] /＃/ prefix}”。
$ {parameter /％pat / string}
如上所述，但与目标相匹配。有助于添加
具有空模式的常见后缀。

You will learn them through experience. They come in handy far more
often than you think they might. Here are a few examples to kick start
you:

您将通过经验学习它们。他们派上用场了
通常比您想象的要多。这是开始的一些例子
您：


``` bash
$ file="$HOME/.secrets/007"; \
echo "File location: $file"; \
echo "Filename: ${file##*/}"; \
echo "Directory of file: ${file%/*}"; \
echo "Non-secret file: ${file/secrets/not_secret}"; \
echo; \
echo "Other file location: ${other:-There is no other file}"; \
echo "Using file if there is no other file: ${other:=$file}"; \
echo "Other filename: ${other##*/}"; \
echo "Other file location length: ${#other}"
File location: /home/lhunath/.secrets/007
Filename: 007
Directory of file: /home/lhunath/.secrets
Non-secret file: /home/lhunath/.not_secret/007
```
Other file location: There is no other file
Using file if there is no other file: /home/lhunath/.secrets/007
Other filename: 007
Other file location length: 26

bash
$ file =“ $ HOME / .secrets / 007”; \
回显“文件位置：$ file”； \
回声“文件名：$ {file ## * /}”; \
回显“文件目录：$ {file％/ *}”； \
回声“非保密文件：$ {file / secrets / not_secret}”； \
回声; \
echo“其他文件位置：$ {other：-没有其他文件}”; \
echo“如果没有其他文件，则使用文件：$ {other：= $ file}”； \
回声“其他文件名：$ {other ## * /}”； \
回声“其他文件位置长度：$ {＃other}”
文件位置：/home/lhunath/.secrets/007
档名：007
文件目录：/home/lhunath/.secrets
非保密文件：/home/lhunath/.not_secret/007
```
其他文件位置：没有其他文件
如果没有其他文件，则使用文件：/home/lhunath/.secrets/007
其他文件名：007
其他文件位置长度：26

Remember the difference between${v#p}and${v##p}. The doubling of
the#character means patterns will become greedy. The same goes for%:

记住$ {v＃p}和$ {v ## p}之间的区别。翻倍
＃字符表示模式将变得贪婪。同样适用于％：

$ version=1.5.9; echo "MAJOR: ${version%%.*}, MINOR: ${version#*.}."
MAJOR: 1, MINOR: 5.9.  $ echo "Dash: ${version/./-}, Dashes:
${version//./-}."  Dash: 1-5.9, Dashes: 1-5-9.

$版本= 1.5.9; echo“主要：$ {version %%。*}，次要：$ {version＃*。}。”
主要：1，次要：5.9。 $ echo“ Dash：$ {version /./-}，破折号：
$ {version //./-}。“破折号：1-5.9，破折号：1-5-9。

Note: Youcannotuse multiple PEs together. If you need to execute
multiple PEs on a parameter, you will need to use multiple statements:

注意：您不能一起使用多个PE。如果您需要执行
一个参数上有多个PE，则需要使用多个语句：

$ file=$HOME/image.jpg; file=${file##*/}; echo "${file%.*}"  image

$ file = $ HOME / image.jpg; file = $ {file ## * /};回显“ $ {file％。*}”图像

- Good Practice: You may be tempted to use external applications such
  assed,awk,cut,perlor others to modify your strings. Be aware that
  all of these require an extra process to be started, which in some
  cases can cause slowdowns. Parameter Expansions are the perfect
  alternative.

-良好做法：您可能会想使用外部应用程序，例如
  协助，修改，削减，请他人修改您的字符串。意识到
  所有这些都需要额外的流程才能启动，在某些情况下
  情况可能会导致速度下降。参数扩展是完美的
  替代。

- In The Manual: Shell Parameter Expansion^1

-在手册中：Shell参数扩展^ 1
- In the FAQ: How do I do string manipulations in bash?^2
- How can I rename all my *.foo files to *.bar, or convert spaces to
  underscores, or convert upper-case file names to lower case?

-如何将所有* .foo文件重命名为* .bar，或将空格转换为
  下划线，还是将大写文件名转换为小写？
- How can I use parameter expansion? How can I get substrings? How can
  I get a file without its extension, or get just a file’s extension?

-如何使用参数扩展？如何获得子字符串？怎么能
  我得到的文件没有扩展名，还是仅文件的扩展名？
- How do I get the effects of those nifty Bash Parameter Expansions in
  older shells?

-如何获得这些漂亮的Bash参数扩展的效果
  较旧的炮弹？
- How do I determine whether a variable is already defined? Or a
  function?

-如何确定变量是否已定义？或一个
  功能？
- Parameter Expansion: Any expansion (see earlier definition) of a
  parameter. Certain operations are possible during this expansion
  that are performed on the value that will be expanded.

-参数扩展：a的任何扩展（请参见前面的定义）
  参数。在扩展过程中某些操作是可能的
  对将要扩展的值执行的操作。

(^1)
[http://www.gnu.org/software/bash/manual/bashref.html#Shell-Parameter-Expansion](http://www.gnu.org/software/bash/manual/bashref.html#Shell-Parameter-Expansion)
(^2)
[http://mywiki.wooledge.org/BashFAQ/100](http://mywiki.wooledge.org/BashFAQ/100)
(^3)
[http://mywiki.wooledge.org/BashFAQ/030](http://mywiki.wooledge.org/BashFAQ/030)
(^4)
[http://mywiki.wooledge.org/BashFAQ/073](http://mywiki.wooledge.org/BashFAQ/073)
(^5)
[http://mywiki.wooledge.org/BashFAQ/074](http://mywiki.wooledge.org/BashFAQ/074)
(^6)
[http://mywiki.wooledge.org/BashFAQ/083](http://mywiki.wooledge.org/BashFAQ/083)

（^ 1）
[http://www.gnu.org/software/bash/manual/bashref.html#Shell-Parameter-Expansion](http://www.gnu.org/software/bash/manual/bashref.html#Shell-参数扩展
（^ 2）
[http://mywiki.wooledge.org/BashFAQ/100](http://mywiki.wooledge.org/BashFAQ/100）
（^ 3）
[http://mywiki.wooledge.org/BashFAQ/030](http://mywiki.wooledge.org/BashFAQ/030）
（^ 4）
[http://mywiki.wooledge.org/BashFAQ/073](http://mywiki.wooledge.org/BashFAQ/073）
（^ 5）
[http://mywiki.wooledge.org/BashFAQ/074](http://mywiki.wooledge.org/BashFAQ/074）
（^ 6）
[http://mywiki.wooledge.org/BashFAQ/083](http://mywiki.wooledge.org/BashFAQ/083）
