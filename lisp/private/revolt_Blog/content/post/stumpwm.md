+++
title = "stumpwm"
date = 2020-03-18T00:00:00+08:00
lastmod = 2020-03-29T00:58:41+08:00
tags = ["window-manager"]
categories = ["windowmanger"]
draft = false
locale = "en_US"
autoCollapseToc = true
+++

Stumpwm - happy hacking tools.

<!--more-->


## Basic Concepts {#basic-concepts}


### Screens and Heads {#screens-and-heads}

A screen is an Xlib Concepts representing a section of video
memory onto which physical monitors,called "Headers",are mapped.A
screen can be thought of as an abstract rectangle containing all
the heads arranged in a particular layout.

With most morden systems,you'll only have a single screen no
matter how many heads are connected to your computer.Each header
will have its own frame,and you can move betwween heads using the
normal frame movement commands.

The layout of the heads within the screen can be specified in one
of two ways: either at statup using your ststem's Xorg
configuration files,or on the fly using tools like XRandR.if the
computer is botted with multiple monitors attached,but without
specifying a layout for them,they will all show identical output.

StumpWM will attempt to detect the layout of the head once at
startup,or any time a RandR command is issued.

In rarer setups you may have multiple screens,with one head per
screen.That means that you'll move between heads using screen
movement commands ('snext','sprev',and 'sother') ranther than
frame movement commands.


### Groups Basic {#groups-basic}

A group is usually refered to as a "desktop" or "workspace" in
other window managers.StumpsWM starts with a single group,called
"Default".Each group has its own configuration or frames and
windows that is sepatate from and independent of other groups.You
can't have different groups display in different monitors: when
you switch groups,all monitors switch to that group.

Each group contains an ordered list of frames.


### Floating Group Basics {#floating-group-basics}

Within a floating group,windows behave more like they do in
traditional window managers: rather than being arranged into
frames,they each have their own box,which can be freely _resized_
and _repositioned_,and allowed to _ovelap_.Each window has a
thicker border at the top.left click in this border and drag to
move the windows,or right click and drag to resize it.

Most of the window-switching commands listed below do not function
in a floating group.You're restricted to \`Other\`,the \`select-window-\*\`
commands,and \`windowlist\`.


### Frame Basic {#frame-basic}

Frames are the boxes within windows are displayed.StumpWM starts
with a single frame per head,meaning that each monitor shows a
single window,full screen.If you want to see windows
side-by-side,you can "split" this frame in two,either vertically
or horizontally.These frames can be further split,creating nested
boxes.

Technically speaking,frames live within a "frame tree".When you
split a frame,the command actually creates two new frames
side-by-side(并排) within the original parent frame.This make no
practical difference,unless you use the \`sibling\` command,which
will move to the other child frame within the parent frame.

Within this frame tree model,all frames either contain other
frames,or windows.The command \`fclear\` will hide all a frame's
windows and show the background.


### Window Basics {#window-basics}

Windows are created by programs to display their output.They take
the shape of the frame in which they are created.The windows
within a frame are ordered by how recently that window was
focused.Only the tip window in the stack is visible.


### System Trays(托盘) and the Mode line {#system-trays--托盘--and-the-mode-line}

Many users choose to sacrifice a little screen real-estate to
display some generally useful information: the current time and
date,wireless network connections,the names of open
windows,etc.StumpWM allows you to display this information in a
bar across either the top or the button of the screen.There are
two ways to do this: using external programs called system
trays,or using StumpWM's own mode line.

System trays are a special kind of X window.They advertise to
running programs that they are available for embedding icons or
notifications from those programs.

They often also display clickalble icons for each open
window.Common tray programs include the GNOME pannel or KDE's
kicker,or simple programs such as stalonetray.Simply starting one
of these programs is usually enough for StumpWM to detect it,place
it correctly,and allow it to function normally.

The mode line,a concept borrowed form Emacs,is a built-in part of
StumpWM.It is essentially a string of text that can include a
variety of information about your current session,including the
names of current groups and windows.Several contrib modules
provide for different types of information.See the Mode Line
section of the manual(and the contrib directory) for more.

到这里，已经熟悉了些基本概念。就不用抄了。然后简单熟悉一下SBCL吧。
然后需要安装 `Slime`.


### SLIME {#slime}

SLIME,the superior lisp interaction Mode for Emacs,is an Emacs
mode for developing _Common Lisp_ applications.SLIME uses a
backend called Swank that is loaded into Common Lisp.

Slime works with the following Common Lisp implementations:

-   CMU Common Lisp
-   Scieneer Common Lisp
-   Stell Bank Common Lisp (SBCL)
-   Clozure CL (former OpenMCL)
-   LispWorks
-   Allegro Common Lisp
-   CLISP
-   Embeddable Common Lisp(ECL)
-   Armed Bear Common Lisp(ABCL)

Some implementations of other programming languages are using
SLIME:

-   Clojure
-   JS
-   kawa, a Scheme implementations
-   GNU R
-   Ruby
-   MIT Scheme
-   Scheme48

So,now we should learn How to use Slime mode.Switch [here](https://common-lisp.net/project/slime/doc/html/Introduction.html#Introduction).


## Command {#command}

-   `C-t ;`,could input `time` display current time.
-   `C-t e`,run emacs.
-   `C-t c`,run xterm.
-   `C-t w`,see list of window.
-   `C-t a`,display current time.
-   `C-t s`,vsplit windows.
-   `C-t TAB`,switch to the empty frame.
-   `C-t M-TAB`,jumps to the last frame that had focus.
-   `C-t o` jumps to the next frame in the current group's frame list.
-   `C-t w`,show window list.
-   `C-t !`,pop input bar.now could run a shell command.for
    example,start a web browser: firefox.
-   `C-t Q` remove all frames but the current one and resize it to
    fit the screen.


### Moving Between Frames {#moving-between-frames}

Once you have multiple frames,you can move between them in various
ways:

-   `fnext` (`C-t o` or `C-t TAB`) jumps to the next frame in the
    current group's frame list.
-   `fother` (`C-t M-TAB`) jumps to the last frame that had focus.
-   `fslect` (`C-t f`) displays numbers on each visible frame: hit
    the number key or click it to move to that frame.
-   `move-focus` (`C-t <arrow key>`) focus the frame from which the
    current frame was split.


### Manipulating Windows {#manipulating-windows}

Some commands change which window is currently focused,some move
windows betweens frames,and some may do both at once.

There are two general ways to move focus between windows: either
between windows belonging to the current frame,or between all
windows within the current group.Within a single frame:

-   `next-in-frame`
-   `prev-in-frame`
-   `other-in-frame`
-   `frame-windowlist`,default show one window.so need more config.

Within the cuttent group,the following commands will go straight
to the specified window.

-   `next`
-   `prev`
-   `next-urgent`
-   `select` or `select-window` command is `C-t '` ,just input title
    of window.about the title of windows,could press `C-t w` look.
-   `select-windows-by-name` (unbound by defualt) prompt for the
    title of a window and focus it.Require the window title to be
    entered exactly.
-   `C-t <number>` choose a windows by number.
-   `C-t "` display a menu of windows in the currently-focused
    group.

The following commands always keep the current frame focused.If
the selected window is not in the current frame,it will be pulled
there from wherever it is(hence the "pull" naming scheme).

-   `pull` or `pull-window-by-number` `C-t C-<number>` pull the
    numbered window into the current frame.
-   `pull-hidden-next` `C-t n` or `C-t SPC`
-   `C-t p` `pull-hidden-previous`
-   `pull-hidden-other`

The following commands move the current windows from one frame to
another,bringing focus with them.

-   `move-window` `C-t M-<arrow>` move the currently focused window
    in the direction indicated by the arrow key.Crazy!

-   `exchange-direction` (unbound by defualt) prompt for a
    direction,then swap the currently focused window with the top
    window of the frame in that direction.


### Interacting with the Lisp process {#interacting-with-the-lisp-process}

Since StumpWM is a lisp program,there is a way for you to evaluate
Lisp code directly,on the same lisp process that StumpWM is
running on. Type `C-t :` ,and an input box will appear.Then type
some lisp expression.

When you call `eval` this way,you will be in the `StumpWM-USER`
package,which imports all the exported symbols from the main
STUMPWM package.

```emacs-lisp
*mode-line-border-width*

(setf *mode-line-border-width* 3)

(set-prefix-key (kbd "C-M-H-s-z"))
```


### Init File {#init-file}

The init file is itself a Common lisp program running in a Common
lisp environment,so you can write your own hacks and make them a
part of your stumpWM experience.

now,we should configuration our init file in
`~/.stumpwm.d/init.lisp`

StumpWM includes a basic `simple-stumpwm.lisp` in its source
directory.


## how to customize Stumpwm {#how-to-customize-stumpwm}