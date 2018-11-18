## Declare 

已经配置了webpack很多次了.这次是专门为CSS而构建的.

下面是新遇见的问题.

## Q1

在webpack中的css和js文件中更新chunkhash.

https://stackoverflow.com/questions/44491064/updating-chunkhash-in-both-css-and-js-file-in-webpack

关于css,如果使用`extract-text-webpack-plugin`可以采取md5的hash命名方法.

## Q2

使用`mini-css-extract-plugin`的效果.

现在，当我编辑main.scss时，会生成样式.css的新哈希.

当我编辑css时只有css hash更改，

当我编辑  ./src/script.js时，只有script.js哈希更改.


## postcss插件

https://www.postcss.parts/

## ref_link

https://hackernoon.com/a-tale-of-webpack-4-and-how-to-finally-configure-it-in-the-right-way-4e94c8e7e5c1