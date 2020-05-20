+++
title = "A sets of X command"
date = 2020-03-14T00:00:00+08:00
lastmod = 2020-05-08T00:04:42+08:00
tags = ["linux-command"]
categories = ["linux-command"]
draft = false
locale = "en_US"
autoCollapseToc = true
+++

X系列命令DEMO.

<!--more-->


## X resources <code>[100%]</code> {#x-resources}

Xresources is a user-level configuration dotfile, typically located
at `~/.Xresources`. It can be used to set X resources, which are
configuration parameters for X client applications.&nbsp;[^fn:1]

-   [X] [Installation](#installation)
-   [X] [Usage](#usage)


### Installation {#installation}

need install `xorg-xrdb`.


### Usage <code>[4/4]</code> {#usage}

-   [X] [Load resource file](#load-resource-file)
-   [X] [xinitrc](#xinitrc)
-   [X] [Default settings](#default-settings)
-   [X] [Xresource syntax](#xresource-syntax)


#### Load resource file {#load-resource-file}

Resources are stored in X server,so have to only be read
once.They are also accessible to remote X11 clinets.(such as SSH
转发的内容).

-   `.Xresources`: replacing any current settings.

-   Could use command: `echo "xrdb ~/.Xresources"` `xrdb ~/.Xresources`

-   Load a resource file merger with the current
    settings: `echo "xrdb -merge ~/.Xresources"` `xrdb -merge ~/.Xresources`

>Most Display manager load the `/.Xresource` file on login.


#### xinitrc {#xinitrc}

if you are using a copy of the default `xinitrc` as your
`.xinitrc` it already merges `~/.Xresources`.

If you are using a custom `.xinitrc` add the following line: 

```shell
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
```


#### Default settings {#default-settings}

To see the default settings for your installed X11 apps, look in
`/usr/share/X11/app-defaults/`. 

<a id="code-snippet--show-the-x11-default-settings"></a>
```shell
ls -ll "/usr/share/X11/app-defaults/"
```

| total      | 60 |      |      |       |     |    |       |                  |
|------------|----|------|------|-------|-----|----|-------|------------------|
| -rw-r--r-- | 1  | root | root | 2799  | Dec | 23 | 20:21 | GXditview        |
| -rw-r--r-- | 1  | root | root | 601   | Dec | 23 | 20:21 | GXditview-color  |
| -rw-r--r-- | 1  | root | root | 2400  | May | 4  | 11:49 | KOI8RXTerm       |
| -rw-r--r-- | 1  | root | root | 5836  | May | 4  | 11:49 | KOI8RXTerm-color |
| -rw-r--r-- | 1  | root | root | 3609  | May | 4  | 11:49 | UXTerm           |
| -rw-r--r-- | 1  | root | root | 5828  | May | 4  | 11:49 | UXTerm-color     |
| -rw-r--r-- | 1  | root | root | 248   | May | 7  | 10:54 | Xmessage         |
| -rw-r--r-- | 1  | root | root | 920   | May | 7  | 10:54 | Xmessage-color   |
| -rw-r--r-- | 1  | root | root | 10269 | May | 4  | 11:49 | XTerm            |
| -rw-r--r-- | 1  | root | root | 5826  | May | 4  | 11:49 | XTerm-color      |

```shell
xrdb -query -all
```


#### Xresource syntax {#xresource-syntax}

<!--list-separator-->

-  Basic Syntax

    The syntax of an Xresource file is as follows:
    
    ```text
    name.Class.resource: value
    ```
    
    and here is a real world example:
    
    ```text
    xscreensaver.Dialog.headingFont: -*-fixed-bold-r-*-*-*-100-*-*-*-*-iso8859-1
    ```

<!--list-separator-->

-  Wildcard matched

    Using the previous example, if you want to apply the same font
    to all programs (not just XScreenSaver) that contain the class
    name Dialog which contains the resource name headingFont, you
    could write:
    
    ```text
    ?.Dialog.headingFont:     -*-fixed-bold-r-*-*-*-100-*-*-*-*-iso8859-1
    ```
    
    if you want to apply this same rule to all programs that contain the
    resource headingFont, regardless of its class, you could write: 
    
    ```text
    *headingFont:    -*-fixed-bold-r-*-*-*-100-*-*-*-*-iso8859-1
    ```

<!--list-separator-->

-  Comments

    ```text
    ! This is a comment form
    ```

<!--list-separator-->

-  Inlcude files

    TO use different files for each application,use `#include` in
    the main file ,e.g. `~/.Xresources`:
    
    ```text
    ~/.Xresources
    
    --------------------------------------------------
    
    #include ".Xresources.d/xterm"
    #include ".Xresources.d/rxvt-unicode"
    #include ".Xresources.d/fonts"
    #include ".Xresources.d/xscreensaver"
    ```
    
    If file fail to load,specify the directory to _xedb_ with the
    `-I` parameter.e.g.:
    
    ```text
    ~/.xinitrc
    
    xrdb -I$HOME ~/.Xresources
    ```

<!--list-separator-->

-  Getting resource values

    if you want to get the value of a resource,you can use
    `xgetres`.e.g.:
    
    ```shell
    xgetres xterm.metaSendsEscape
    ```


## Xterm {#xterm}

**xterm** is the standard `terminal emulator` for `x window
   system`.It is highly configurable and has many useful and some
unusual features.

目前我遇到的问题就是,在终端下的xtrem 和 Emacs有着巨大的键冲突。很难
忍受。不过问题解决了。

Current Xterm Setting of the follow,the rest of xterm
configuration you can see here&nbsp;[^fn:2]:

```shell
!support chinese fonts
!中文测试
XTerm.vt100.faceName: all-the-icons:size=9:antialias=True:pixelsize=12
XTerm.vt100.faceNameDoublesize: Wenquanyi Zen Hei:style=Regular,Bold,Italic:size=10:antialias=True:pixelsize=12
XTerm*scaleHeight: 1.01
XTerm*locale:zh_CN.UTF-8

!backrgound color settings
XTerm*foreground: white
XTerm*background: black

!use mouse select text color is yellow,not evil select color,so sadness.
!about Xterm select,you can see here: https://jonasjacek.github.io/colors/

XTerm*highlightColor: yellow
XTerm*highlightTextColor: yellow
XTerm*highlightColorMode: true
XTerm*cursorColor: LightGoldenrod3
XTerm*pointerShape: arrow
XTerm*pointerColor: blue

!init window size
XTerm*geometry:100x32

!dynamic color
XTerm*dynamicColors:true

!xterm M key configuration
XTerm*metaSendsEscape: true

!TERM Environmental variable			 
XTerm*termName: xterm-256color

!Ensure that your locale is set up for UTF-8.you may need to force xterm to more strictly follow you locale by setting.
!XTerm.vt100.locale: true


!Make 'Alt' key behave as on other terminal emulators
XTerm.vt100.metaSendsEscape: true

!Fix the backspace key, This breaks the Ctrl+H key combination on Emacs. now fix it.
XTerm.vt100.backarrowKey: false
XTerm.ttyModes: erase ^?


!key binding
!#override indicates that these bindings should override any existing ones
!Each binding must be separated by the escape sequence \n. If you want
!to insert a literal newline, it also needs to be escaped (hence \n\).)

!XTerm.vt100.translations: #override \n\
!    Ctrl <Key>M: maximize() \n\
!    Ctrl <Key>R: restore()

!鼠标左键CLICK，即可向浏览器粘贴.
!从浏览器往XTERM中粘贴,C-S t.或者Linux自带的C-;

!Xterm could copy clipboard
XTerm*selectToClipboard: true

!下面是Xterm自定义键
*VT100*translations:      #override \n\
    Ctrl Shift <Key>C:  copy-selection(SELECT) \n\
    Ctrl Shift <Key>V:  insert-selection(CLIPBOARD)

!Scrolling, i dont want to fix it.Cause I use Emacs evil mode.

!enable Xterm Menus
XTerm.vt100.geometry: 80x32
```

now left the M-RET not working in Emacs org mode in Xterm,but have
alternative Keys in Terminal/putty,[See Using Org on a TTY](https://orgmode.org/manual/TTY-Keys.html#TTY-keys).

because in the terminal,so the `M-RET` should press `C-c C-x
   m`.very bad feel.but it's working.


### How to open multi xterm window? {#how-to-open-multi-xterm-window}

```shell
#!/bin/bash
xterm -geometry 80x27+1930+0 &
xterm -geometry 80x27+2753+0 &
xterm -geometry 80x27+1930+626 &
xterm -geometry 80x27+2753+626 &
```

fell bad,so give up the idea,may be could use stumpwm slove the problem.


### <span class="org-todo todo TODO">TODO</span> how to change the title of an Xterm {#how-to-change-the-title-of-an-xterm}

[ref](https://tldp.org/HOWTO/Xterm-Title.html)


### How to slove cpoy/paste in Xterm? {#how-to-slove-cpoy-paste-in-xterm}

现在我们需要解决这个问题。因为真的太TM的烦人。

Xterm is compiled with _toolbar_,or _menubar_,disabled.The menus
are still available as `popups` when you press `C MouseButton`
within the xterm window.The actions invoked by the menu items can
often be accomplished using command line options or by setting
resource values.

Some of the menu options are discussed below:


### <span class="org-todo todo TODO">TODO</span> Main Options menu {#main-options-menu}


#### Ctrl + leftmouse {#ctrl-plus-leftmouse}

-   `Secure Keyboard` attempts to ensure only the xterm window,and
    no other application,receive your keystorkes.
-   `Allow SendEvents` allows other processs to send keypress and
    mouse events to the xterm window.Because of the security
    risk,do not enable this unless you are very sure you know what
    you are doing.

[^fn:1]: [X resources](https://wiki.archlinux.org/index.php/X%5Fresources)
[^fn:2]: [XTerm](https://wiki.archlinux.org/index.php/Xterm#VT%5FFonts%5Fmenu)