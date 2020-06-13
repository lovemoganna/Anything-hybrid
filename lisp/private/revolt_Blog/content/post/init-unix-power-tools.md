+++
title = "Unix power tools"
date = 2020-05-19T00:00:00+08:00
lastmod = 2020-05-24T16:19:04+08:00
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
  651 ?        Ss     0:00 /usr/lib/systemd/systemd --user
  652 ?        S      0:00 (sd-pam)
  661 ?        S      0:00 /usr/bin/kwalletd5 --pam-login 7 3
  662 ?        Sl    14:11 /usr/bin/stumpwm
  670 ?        Ss     0:00 /usr/bin/dbus-daemon --session --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
  673 ?        Sl     0:11 fcitx
  683 ?        Ss     0:00 /usr/bin/dbus-daemon --syslog --fork --print-pid 4 --print-address 6 --config-file /usr/share/fcitx/dbus/daemon.conf
  687 ?        SN     0:00 /usr/bin/fcitx-dbus-watcher unix:abstract=/tmp/dbus-8tyfTxJD0k,guid=fecdd2284141e57d98b17e8e5ec8d7cd 683
  695 ?        Sl     3:19 qv2ray
  751 ?        Sl     0:00 /usr/lib/dconf-service
 2930 ?        Sl     1:52 /usr/lib/v2ray/v2ray -config /home/revolt/.config/qv2ray/generated/config.gen.json
 2979 ?        Sl    19:57 /usr/lib/firefox/firefox
 2998 ?        Ssl    0:00 /usr/lib/gvfsd
 3004 ?        Sl     0:00 /usr/lib/gvfsd-fuse /run/user/1000/gvfs -f
 3069 ?        Ssl    0:00 /usr/lib/at-spi-bus-launcher
 3099 ?        Sl     0:19 /usr/lib/firefox/firefox -contentproc -childID 1 -isForBrowser -prefsLen 1 -prefMapSize 220399 -parentBuildID 20200509015111 -appdir /usr/lib/firefox/browser 2979 true tab
 3144 ?        S      0:15 xterm
 3155 pts/0    Ss     0:00 zsh
 3197 ?        S<sl   0:18 /usr/bin/pulseaudio --daemonize=no
 3264 ?        Sl     0:00 /usr/lib/pulse/gsettings-helper
 3272 ?        Sl     2:33 /usr/lib/firefox/firefox -contentproc -childID 3 -isForBrowser -prefsLen 6442 -prefMapSize 220399 -parentBuildID 20200509015111 -appdir /usr/lib/firefox/browser 2979 true tab
 3375 ?        Sl     0:01 /usr/bin/plasma-browser-integration-host /usr/lib/mozilla/native-messaging-hosts/org.kde.plasma.browser_integration.json plasma-browser-integration@kde.org
 3397 ?        Sl     9:22 /usr/lib/firefox/firefox -contentproc -childID 5 -isForBrowser -prefsLen 7248 -prefMapSize 220399 -parentBuildID 20200509015111 -appdir /usr/lib/firefox/browser 2979 true tab
 3450 ?        SLl    0:03 /usr/lib/kdeconnectd
 3640 pts/0    Sl+    1:15 emacs -nw
 3810 ?        S      0:01 xterm
 3813 pts/1    Ss+    0:13 zsh
 4506 ?        Sl     2:11 /usr/lib/firefox/firefox -contentproc -childID 8 -isForBrowser -prefsLen 12156 -prefMapSize 220399 -parentBuildID 20200509015111 -appdir /usr/lib/firefox/browser 2979 true tab
 4770 ?        Sl     0:27 /usr/lib/firefox/firefox -contentproc -childID 10 -isForBrowser -prefsLen 12157 -prefMapSize 220399 -parentBuildID 20200509015111 -appdir /usr/lib/firefox/browser 2979 true tab
 5420 ?        S      0:00 /usr/bin/dbus-daemon --config-file=/usr/share/defaults/at-spi2/accessibility.conf --nofork --print-address 3
 5427 ?        Sl     0:01 /usr/lib/at-spi2-registryd --use-gnome-session
22173 pts/1    Sl     1:27 ./firefox.real --class Tor Browser -profile TorBrowser/Data/Browser/profile.default
22245 pts/1    S      0:07 /home/revolt/tor-browser_en-US/Browser/TorBrowser/Tor/tor --defaults-torrc /home/revolt/tor-browser_en-US/Browser/TorBrowser/Data/Tor/torrc-defaults -f /home/revolt/tor-browser_en-US/Browser/TorBrowser/Data/Tor/torrc DataDirectory /home/revolt/tor-browser_en-US/Browser/TorBrowser/Data/Tor GeoIPFile /home/revolt/tor-browser_en-US/Browser/TorBrowser/Data/Tor/geoip GeoIPv6File /home/revolt/tor-browser_en-US/Browser/TorBrowser/Data/Tor/geoip6 HashedControlPassword 16:f4f85b31fe5b244d60be58a90b4dda505cd40e94d19b874ee206563bd8 +__ControlPort 9151 +__SocksPort 127.0.0.1:9150 IPv6Traffic PreferIPv6 KeepAliveIsolateSOCKSAuth __OwningControllerProcess 22173
22355 pts/1    Sl     0:02 ./TorBrowser/Tor/PluggableTransports/obfs4proxy
22435 pts/1    Sl     0:16 /home/revolt/tor-browser_en-US/Browser/firefox.real -contentproc -childID 2 -isForBrowser -prefsLen 899 -prefMapSize 223657 -parentBuildID 20200402110101 -greomni /home/revolt/tor-browser_en-US/Browser/omni.ja -appomni /home/revolt/tor-browser_en-US/Browser/browser/omni.ja -appdir /home/revolt/tor-browser_en-US/Browser/browser 22173 tab
22503 pts/1    Sl     1:55 /home/revolt/tor-browser_en-US/Browser/firefox.real -contentproc -childID 3 -isForBrowser -prefsLen 899 -prefMapSize 223657 -parentBuildID 20200402110101 -greomni /home/revolt/tor-browser_en-US/Browser/omni.ja -appomni /home/revolt/tor-browser_en-US/Browser/browser/omni.ja -appdir /home/revolt/tor-browser_en-US/Browser/browser 22173 tab
22747 pts/1    Sl     1:28 /home/revolt/tor-browser_en-US/Browser/firefox.real -contentproc -childID 4 -isForBrowser -prefsLen 1925 -prefMapSize 223657 -parentBuildID 20200402110101 -greomni /home/revolt/tor-browser_en-US/Browser/omni.ja -appomni /home/revolt/tor-browser_en-US/Browser/browser/omni.ja -appdir /home/revolt/tor-browser_en-US/Browser/browser 22173 tab
23049 pts/1    Sl     0:00 /home/revolt/tor-browser_en-US/Browser/firefox.real -contentproc -childID 5 -isForBrowser -prefsLen 1993 -prefMapSize 223657 -parentBuildID 20200402110101 -greomni /home/revolt/tor-browser_en-US/Browser/omni.ja -appomni /home/revolt/tor-browser_en-US/Browser/browser/omni.ja -appdir /home/revolt/tor-browser_en-US/Browser/browser 22173 tab
28482 ?        Sl     2:33 /usr/lib/firefox/firefox -contentproc -childID 14 -isForBrowser -prefsLen 12634 -prefMapSize 220399 -parentBuildID 20200509015111 -appdir /usr/lib/firefox/browser 2979 true tab
33788 ?        Sl    19:31 /usr/lib/firefox/firefox -contentproc -childID 15 -isForBrowser -prefsLen 12702 -prefMapSize 220399 -parentBuildID 20200509015111 -appdir /usr/lib/firefox/browser 2979 true tab
56044 ?        Sl     1:19 /usr/lib/firefox/firefox -contentproc -parentBuildID 20200509015111 -prefsLen 14377 -prefMapSize 220399 -appdir /usr/lib/firefox/browser 2979 true rdd
58844 ?        Ss     0:00 /usr/bin/zsh
58845 ?        R      0:00 ps x
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

-   Upper -and lowercase characters
    
    Unix filenames are always case senstive.

-   Underscores(\_)
    
    make filename more readable.

-   Periods(.)
    1.  filename extensions.
    2.  Filenames that begin with a period are treated specially by
        the shell: wildcards won't match them unless you include the
        period (like .\*). The ls command,which lists your file,ignore
        files whose begin with a period unless you give it a special
        option.
        
        ```shell
        ls -a
        ```

-   Certains other punctuation.
    
    comma(,) , is safe.

-   Some things to be aware of:
    
    1.Unix dose not have any concept of a file version.
    2.Once you delete a file in Unix, it is ****gone forever****.You
    can't get it back without restoring it from a backup.May be you
    should have a "grace period".


### Filename Extensions {#filename-extensions}

Filename extensions for user's benefit:

| Extension       | Description                           |
|-----------------|---------------------------------------|
| .tar            | `tar` archive                         |
| .tar.gz or .tgz | `gzip` ped tar archive                |
| .shar           | Shell archive                         |
| .sh             | Bournel shell script                  |
| .csh            | C Shell script                        |
| .mm             | Text file containing troffs mm macros |
| .ms             | Text file containing troffs ms macros |
| .ps             | PostScript source file                |


### Wildcards {#wildcards}

The shells provide a number of wildcards that you can use to
abbreviate filenames or refer to groups of files.

For example,let's say you want to delete all filenames ending in
`/.txt` in the current directory.

The wildcard is the "regardless" part. Like a wildcard in a poker
game,a wildcard in a filename can have any value.

When `?` appears in a filename, the `?` matches any single
character.For example, `letter?` refers to any filename that
begins with letter and has exactly one character after that.

```shell
ls -a ./demo-1 | egrep "^aa?"	# ? 匹配带有 0 个 / 1 个 带 a 的文件名
```


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