+++
title = "Unix power tools"
date = 2020-05-19T00:00:00+08:00
lastmod = 2020-05-21T20:49:24+08:00
tags = ["linux-command"]
categories = ["linux-command"]
draft = false
locale = "en_US"
autoCollapseToc = true
+++

Unix is not an operating system as much as it is a way of thinking.

<!--more-->

It is the idea that the power of a system comes more from the
relationships among programs than from the programs themseleves.

No single program,however well thought out,will solve every problem.

many situation that runs counter(相反) to the expected.

Faced with a choice between an hour spent on a boring,repetitive task
and an hour putting together a tool that will do the task in a flash?

One key concept is that programs are tools.


## Shell {#shell}


### Check which kinds of you running shell {#check-which-kinds-of-you-running-shell}

```shell
grep revolt /etc/passwd
```

```tcsh
grep revolt /etc/passwd
```

-   Sun's Network Information Service?
-   NetInfo: store `/etc/passwd` location.

-   generate mac file

<!--listend-->

```shell
hello mac file
```

2.convert mac file to unix file

```shell
tr '\015' '\012' convert.mac convert.unix
```

3.we will use more kinds of shell,for example, C shell.

```text
ysy -S tcsh
```


### Internal and External Commands {#internal-and-external-commands}

for example:

-   built-in: _cd_ command
-   external: /bin/ls&nbsp;[^fn:1]

The shell doesn't start a separate process to run internal
commands.External commands require the shell to _fork_ and `exec`
a new ****subprocess****. this takes some time, especially on a [Busy System](https://baike.baidu.com/item/%25E7%25B3%25BB%25E7%25BB%259F%25E6%2580%25BB%25E7%25BA%25BF).

When you type the name of a command:

-   Shell first checks to see it is or not built-in command.
    -   if so, execute it.
    -   if the command name is an absolute pathname.begining with
        `/`.the command is likewise executed.
    -   if the command is neither built-in nor specified with an
        absoulute pathname,most shells will check for ****aliaes**** or
        ****shell functions****.which may have been defined by the user --
        often in a ****shell setup file**** that was read then the shell started.
    -   Most shells also "remember" the location of external command.

The search path isn't built into the shell; it's something you
specify in your shell setup files.

By tradition, Unix system programs are kept in directories called
`/bin/` and `/usr/bin/`, with additinal programs usually used only
by system administrators in either `/etc/` and `/usr/etc/` or
`/sbin` and `/usr/sbin/`. Many versions of Unix also have programs
stored in `/usr/ucb/` (the mean is University of California at
Berkeley).

There may be other directories containing programs.For Example:

X Window System
: 1.  stored path: `/usr/bin/X11`


user own directories
: 1.  `/usr/local/bin` or `/opt/`

The Search Path is stored in an ****environment variable**** called
`PATH`.

```shell
echo $PATH
```

The path is searched in order.your `local` command we mentioned
earlier will be executed.


### The kernel and Daemons {#the-kernel-and-daemons}

Unix is always will be a multiuser operating system.This reflected
in the latter a few ways.

-   just only person using it.
-   it is running on a PC with a single keyboard.

Unix is always doing things "behind your back" (背后做事),running
programms of its own,whether you are aware of it or not. The most
important of these programs, the ****kernel****,is the heart of the
Unix operating system itself.

The kernel assings memory to each of the programs that are
running,partition time(时间分割) fairly so that each program can
get its job done, handles all I/O (input/output) operations, and
so on.

Another important group of programs,called `daemons`,are the
system's hyplers. They run continuously(连续不断的) -- or form
time to time -- performing small but important tasks like handling
mail, running network communications, feeding data to your
printer,keeping track of the time,and so on.

Not only are your sharing the computing with the kernel and some
mysterious daemons, you're also sharing it with yourself.

You can issue the `ps x` command to get a list of all processes
running on your system. For example:

```shell
ps x
```

```text
   PID TTY      STAT   TIME COMMAND
   563 ?        Ss     0:00 /usr/lib/systemd/systemd --user
   564 ?        S      0:00 (sd-pam)
   677 ?        Sl     0:00 /usr/bin/startplasma-x11
   684 ?        Ss     0:00 /usr/bin/dbus-daemon --session --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
   748 ?        Sl     0:00 /usr/lib/dconf-service
   762 ?        Sl     0:00 /usr/bin/plasma_session
   780 ?        Rl   589:15 /usr/bin/kwin_x11 -session 10bdca6d61000158998168400000006870007_1589982425_893779
   792 ?        SNl    0:00 /usr/bin/baloo_file
   884 ?        SNl    0:00 /usr/lib/tracker-miner-fs
   887 ?        Sl     0:00 /usr/lib/tracker-miner-rss
   907 ?        Sl     0:00 /usr/lib/telepathy/mission-control-5
   910 ?        Ssl    0:00 /usr/lib/gvfsd
   954 ?        Sl     0:00 /usr/lib/gvfsd-fuse /run/user/1000/gvfs -f
   990 ?        Ssl    0:00 /usr/lib/gvfs-udisks2-volume-monitor
  1147 ?        Ss     0:00 /usr/lib/bluetooth/obexd
  1353 ?        S<sl   0:01 /usr/bin/pulseaudio --daemonize=no
  1369 ?        Sl     0:00 /usr/lib/pulse/gsettings-helper
  1384 ?        S      0:00 /usr/bin/kwalletd5 --pam-login 7 3
  1385 ?        Sl    10:10 /usr/bin/stumpwm
  1403 ?        Sl     0:11 fcitx
  1412 ?        Ss     0:00 /usr/bin/dbus-daemon --syslog --fork --print-pid 4 --print-address 6 --config-file /usr/share/fcitx/dbus/daemon.conf
  1417 ?        SN     0:00 /usr/bin/fcitx-dbus-watcher unix:abstract=/tmp/dbus-sXxpaFe8ed,guid=7e73b502f66d1f9069502de05ec5eea6 1412
  1423 ?        Sl     0:00 /usr/bin/kglobalaccel5
  1430 ?        Sl     1:20 qv2ray
  1628 ?        Ssl    0:00 /usr/lib/at-spi-bus-launcher
  1634 ?        S      0:00 /usr/bin/dbus-daemon --config-file=/usr/share/defaults/at-spi2/accessibility.conf --nofork --print-address 3
  1638 ?        Sl     0:00 /usr/lib/at-spi2-registryd --use-gnome-session
  2164 ?        S      0:17 xterm
  2166 pts/0    Ss     0:00 zsh
  2701 ?        Sl    19:14 /usr/lib/firefox/firefox
  2807 ?        Sl     1:54 /usr/lib/firefox/firefox -contentproc -childID 3 -isForBrowser -prefsLen 6310 -prefMapSize 220269 -parentBuildID 20200509015111 -appdir /usr/lib/firefox/browser 2701 true tab
  2925 ?        Sl     0:48 /usr/lib/firefox/firefox -contentproc -childID 4 -isForBrowser -prefsLen 7042 -prefMapSize 220269 -parentBuildID 20200509015111 -appdir /usr/lib/firefox/browser 2701 true tab
  3082 ?        Sl     0:00 /usr/bin/plasma-browser-integration-host /usr/lib/mozilla/native-messaging-hosts/org.kde.plasma.browser_integration.json plasma-browser-integration@kde.org
  3124 ?        SLl    0:01 /usr/lib/kdeconnectd
  3276 ?        Sl     1:32 /usr/lib/firefox/firefox -contentproc -childID 8 -isForBrowser -prefsLen 7353 -prefMapSize 220269 -parentBuildID 20200509015111 -appdir /usr/lib/firefox/browser 2701 true tab
  4254 ?        Sl     3:03 /usr/lib/firefox/firefox -contentproc -childID 21 -isForBrowser -prefsLen 9206 -prefMapSize 220269 -parentBuildID 20200509015111 -appdir /usr/lib/firefox/browser 2701 true tab
 16422 ?        Sl     0:29 /usr/lib/v2ray/v2ray -config /home/revolt/.config/qv2ray/generated/config.gen.json
 17647 ?        Sl     3:16 /usr/lib/firefox/firefox -contentproc -childID 23 -isForBrowser -prefsLen 10177 -prefMapSize 220269 -parentBuildID 20200509015111 -appdir /usr/lib/firefox/browser 2701 true tab
 22153 ?        S      0:02 xterm
 22156 pts/2    Ss     0:02 zsh
 23639 ?        Sl     7:57 /usr/lib/firefox/firefox -contentproc -childID 24 -isForBrowser -prefsLen 10187 -prefMapSize 220269 -parentBuildID 20200509015111 -appdir /usr/lib/firefox/browser 2701 true tab
 23783 pts/2    S      0:00 /bin/bash
 23944 pts/2    S      0:12 zsh
 53464 ?        Sl     0:00 /usr/lib/gvfsd-trash --spawner :1.61 /org/gtk/gvfs/exec_spaw/0
 53498 ?        Ssl    0:00 /usr/lib/gvfsd-metadata
 74323 ?        Sl     0:17 /usr/lib/firefox/firefox -contentproc -childID 34 -isForBrowser -prefsLen 10669 -prefMapSize 220269 -parentBuildID 20200509015111 -appdir /usr/lib/firefox/browser 2701 true tab
 74380 ?        Sl     0:19 /usr/lib/firefox/firefox -contentproc -childID 35 -isForBrowser -prefsLen 10669 -prefMapSize 220269 -parentBuildID 20200509015111 -appdir /usr/lib/firefox/browser 2701 true tab
 75024 pts/2    S      0:00 -csh
 75039 pts/2    S      0:00 zsh
 75950 pts/2    S      0:00 -csh
 76000 ?        Sl     0:42 /usr/lib/firefox/firefox -contentproc -childID 37 -isForBrowser -prefsLen 10668 -prefMapSize 220269 -parentBuildID 20200509015111 -appdir /usr/lib/firefox/browser 2701 true tab
 77039 pts/2    S+     0:01 zsh
115698 pts/0    Sl+    0:02 emacs -nw
115929 ?        Ss     0:00 /usr/bin/zsh
115930 ?        R      0:00 ps x
```

User logged into his ****console****, which shows as _tty?_ in the TTY
column,many program running here, including the X Window System.

if you want to see everything that's running,including the
daemons,type the command `ps aux` or `ps -el`.

```shell
ps aux
```

Because there is so much going on at once,The Unix kernel mediates
different demands for time,memory,disks,and so on.

Not only does the kernel need to run your programs, but it also
needs to run the daemons,any programs that other users might want
to start, or any programs that you may have scheduled to run
automatically.

The Unix kernel never takes a vacation: it is always watching over
the ststem.

The Kernel is a manager that schedules many different kinds of
activity, you understand a lot about how Unix works.

you should know that it's bad idea to turn the computer off while
it is writing something to disk. You will probably destory the
disk, and you clould conceivably damage the disk drive.The same is
true is for Unix.

Any of the programs that are running can start doing something to
the disk at any time.One of the daemons makes a point of accessing
the disk drive every 30 seconds or so, just to stay in touch(保持
联系). Therefore, you can't just run a Unix computer off.

You might do all sorts of damage to the system's files. To turn a
Unix system off, you must first run `shutdown`,which kicks
everyone off the system, makes sure the a deamons won't try to
play with disk drive then you aren't looking,and runs `sync` to
make sure that the disks have the latest version of everything.

When you start up a Unix system,it automatically runs `fsck`,which
stands for `filesystem check`; its job is to find out if you shut
down the system correctly and try to fix any damage that might
have happened if you didn't.


### Filenames {#filenames}


## Hacking on Characters with tr {#hacking-on-characters-with-tr}

The tr command is a character translation filter,reading standard
input and either deleting specific charaters or substituting one
character for another.

A string of consecutive ASCII characters can be represented as a
hyphen-separated range.


### Convert all uppercase characters in file to the equivalent {#convert-all-uppercase-characters-in-file-to-the-equivalent}

lowercase characters.

1.  now generate file as text demo.
    
    ```shell
    echo "A b C D e f g" >> a.txt
    ```

2.  check generate file.
    
    ```shell
    bat a.txt
    ```

3.  convert all uppercase character to lowercase character in
    generate files.
    
    ```shell
    tr 'A-Z' 'a-z' < a.txt
    ```


### a frequent trick: convert filenames from all uppercase to all {#a-frequent-trick-convert-filenames-from-all-uppercase-to-all}

lowercase.

1.  show current all files.
    
    ```shell
    for i in `ls`;
    do echo $i;
    done
    ```

2.  generate new uppercase filename file.
    
    ```shell
    touch C.txt D.txt
    ```

3.  convert filename
    
    ```shell
    for i in `ls`;
    # mv -i          prompt before overwriteing
    do mv -i $i `echo $i | tr 'A-Z' 'a-z'`;
    done
    ```


### apply this feature to an entire branch of a file system {#apply-this-feature-to-an-entire-branch-of-a-file-system}

1.  use \`find\` command do some damage.
    
    ```shell
    find ./ -exec ./lowercase.sh {} \;
    ```
    
    ```shell
    find ./ && ./lowercase.sh
    ```
    
    ```shell
    find ./ -exec ./lowercase.sh {} +
    ```

2.  slove find missing argument \`exec\` question
    
    <https://stackoverflow.com/questions/2961673/find-missing-argument-to-exec>


### test your shell version {#test-your-shell-version}

```shell
echo '[]' | tr '[a-z]' A
```

now you use bash version is Berkeley version, cause Berkeley
version also converts the input \`[]\` to A characters because \`[]\`
aren't treated as range operactors.


## <span class="org-todo todo TODO">TODO</span> Filtering Text Through a Unix command {#filtering-text-through-a-unix-command}

When you're editing in vi,you can send a block of text as standard
input to a Unix command. ****The output form this command replaces
the block of text in the buffer.****

vi
: movement keystrokes

[^fn:1]: external program stored in the dir `/bin`.