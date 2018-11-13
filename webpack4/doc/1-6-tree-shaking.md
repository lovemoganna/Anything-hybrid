---
sidebar: auto
meta:
  - name: tree-shaking
    content: tree-shaking
prev: ./1-5-HRM
next: ./1-7-production-env
---

## tree-shaking 

`tree-shaking`是描述移除 JavaScript 上下文中的未引用代码(dead-code)的意思.

与`import` 和 `export`有关.

剔除没有副作用的代码.

css和极个别的JS代码会有副作用.所以不能剔除那些没有使用到的CSS和特殊依赖的JS文件.

`package.json`
```js
 "sideEffects": [
    "./src/some-side-effectful-file.js",
    "*.css"
  ]
```

## 压缩输出

我们已经可以通过 import 和 export 语法，找出那些需要删除的“未使用代码(dead code)”，

然而，我们不只是要找出，还需要在 bundle 中删除它们。

我们将使用 -p(production) 这个 webpack 编译标记，来启用 `uglifyjs` 压缩插件。

`webpack.config.js`
```js
 mode: "production"
```
## 总结

为了学会使用 tree shaking，你必须……

- 使用 ES2015 模块语法（即 import 和 export）。
- 在项目 package.json 文件中，添加一个 "sideEffects" 入口。
- 引入一个能够删除未引用代码(dead code)的压缩工具(minifier)（例如 UglifyJSPlugin）。

