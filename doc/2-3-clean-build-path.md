---
sidebar: auto
meta:
  - name: clean buld path
    content: clean build path
prev: false
next: false 
---

## link 

https://survivejs.com/webpack/building/tidying-up/

## 将修订附加到构建
`npm install git-revision-webpack-plugin --save-dev`

`webpack.part.js`

```js
const webpack = require("webpack");
const GitRevisionPlugin = require("git-revision-webpack-plugin");

exports.attachRevision = () => ({
  plugins: [
    new webpack.BannerPlugin({
      banner: new GitRevisionPlugin().version(),
    }),
  ],
});
```
向生产构建添加小注释以告知已部署的版本是一个好主意。这样您就可以更快地调试潜在问题
