---
sidebar: auto
meta:
  - name: manage-output
    content: manage-output
prev: ./1-2-manage-assets
next: ./1-4-develop
---
# manage output 

## 设置多个入口点

`webpack.config.js`

```js
    entry: {
        app: './src/index.js',
        print: './src/print.js'
    },
    output: {
        filename: '[name].bundle.js',
        path: path.resolve(__dirname, 'dist')
    },
```
webpack 生成 print.bundle.js 和 app.bundle.js 文件，这也和我们在 index.html 文件中指定的文件名称相对应。

但是,在htmL文件里面我们只能使用我们自己写好的文件.如果有很多文件,这是极其不方便的.

所以我们需要安装下面的插件.

### HtmlWebpackPlugin

`yarn add html-webpack-plugin --dev`

`webpack.config.js`
```js
const HtmlWebpackPlugin = require('html-webpack-plugin');

plugins: [
    new HtmlWebpackPlugin({
        title: 'Output Management'
    })
],
```
### 自动清理dist文件夹

`yaen add clean-webpack-plugin --dev`
