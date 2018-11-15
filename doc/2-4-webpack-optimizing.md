---
sidebar: auto
meta:
  - name: optimizing
    content: optimizing
prev: ./2-3-clean-build-path
next: false
---
## Minifying JS
- 缩小JS的方法:

在webpack 4中，通过两个配置字段控制缩小过程：`optimization.minimize`标记以切换它和`optimization.minimizer`数组以配置过程

添加`npm install uglifyjs-webpack-plugin --save-dev`

但是这个不能解析es6代码.所以我们使用下面这个链接来解决这个问题吧.

用`terser-webpack-plugin`这个插件来替换上面的插件.

[参考链接](https://github.com/numb86/boilerplate-vue/pull/2/commits/95fc8cb2f764817b7348f1056c8c2c79a72a678e)

## 加快JS的执行速度

特定的解决方案允许您预处理代码，以便它运行得更快。

它们是缩小技术的补充，可以分为范围提升，预评估和改进解析。

这些技术有时可能会增加整体包大小，同时允许更快的执行速度。

## 缩小CSS

`npm install optimize-css-assets-webpack-plugin cssnano --save-dev`

## 缩小图片
`npm install img-loader --save-dev`

