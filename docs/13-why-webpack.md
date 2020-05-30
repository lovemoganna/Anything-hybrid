
# Table of Contents

1.  [Why webpack](#org0547bf2)


<a id="org0547bf2"></a>

# Why webpack

使用一个物之前,先看下之前他们的面临的烂摊子.

Thinking: 在浏览器运行JS有几个法?
1, 每个功能都写一个脚本.
毛病: 载入太多脚本,有网络问题

1.  一个大JS文件.

毛病: 维护,可读性,范围,大小问题.

-   立即调用函数表达式(IIFE)

-   Js modules happened form node,js

webpack runs on Node,js, a javascript runtime that can be used in computers and servers outside a browser environment.

commonjs come out and introduced `require`,which allows you to load and use a module in the current file.

This solved scope issues out of the box by importing each module as it was needed,

