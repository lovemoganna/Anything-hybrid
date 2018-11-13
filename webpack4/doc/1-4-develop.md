---
sidebar: auto
meta:
  - name: develop
    content: develop
prev: ./1-3-manage-output
next: ./1-5-HRM
---
# develop 

## 使用sourcemap

webpack打包源代码的时候,如果将`a.js,b.js,c.js`打包到一个`bundle.js`里面.会很难跟踪到源代码的错误和原始位置.

如果使用了`source map`,就可以轻松的追踪到错误出自于哪个文件.

`webpack.config.js`
```js
devtool: 'inline-source-map'
```

## 使用观察模式

`package.json`
```js
"watch": "webpack --watch",
```

对一个文件作出修改后,webpack 自动重新编译修改后的模块.

## 使用WDS
`npm install --save-dev webpack-dev-server`


开启`gzip`压缩.

[参考文章](https://betterexplained.com/articles/how-to-optimize-your-site-with-gzip-compression/)

压缩是一种节省带宽和加快网站速度的简单有效方法。

![image.png](https://upload-images.jianshu.io/upload_images/7505161-5eaa8a5b5e35a981.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```js
  devServer:{
        contentBase: path.join(__dirname, "dist/assets"),
        //gzip压缩
        compress: true,
        port: 9000
    },
```

## 使用 webpack-dev-middleware

webpack-dev-middleware 是一个容器(wrapper)，它可以把 webpack 处理后的文件传递给一个服务器(server)。

通常与`express`一起使用.

`yarn add express webpack-dev-middleware --dev`

设置`webpack.config.js`中的输入目录的路径为相对路径.
```js
    output: {
        filename: '[name].bundle.js',
        path: path.resolve(__dirname, 'dist/assets'),
        // chunkFilename: "[id].chunk.js"    
        publicPath: "/"
    },
```

配置一个后端服务器,引入`webpack.config.js`中的输出目录的路径.

```js
const express = require('express');
const webpack = require('webpack');
const webpackDevMiddleware = require('webpack-dev-middleware');

const app = express();
const config = require('./webpack.config.js');
const compiler = webpack(config);

// Tell express to use the webpack-dev-middleware and use the webpack.config.js
// configuration file as a base.
app.use(webpackDevMiddleware(compiler, {
  publicPath: config.output.publicPath
}));

// Serve the files on port 3000.
app.listen(3000, function () {
  console.log('Example app listening on port 3000!\n');
});
```
运行`node server`即可看到项目运行了.

