---
sidebar: auto
meta:
  - name: HRM
    content: HRM
prev: ./1-4-develop
next: false
---

# HRM

## 直接在WDS上添加

```js
    devServer:{
        contentBase: path.join(__dirname, "dist/assets"),
        //gzip压缩
        compress: true,
        port: 9000,
        // 声明热部署
        hot: true
    },
    plugins: [
        new CleanWebpackPlugin(['dist']),
        new HtmlWebpackPlugin({
            title: 'Output Management'
        }),
        new webpack.SourceMapDevToolPlugin({
            filename: 'sourcemaps/[file].map',
            publicPath: '/',
            fileContext: 'assets'
        }),
        // 添加HMR插件
        new webpack.NamedModulesPlugin(),
        new webpack.HotModuleReplacementPlugin()
    ],
```
## 与Node API集成
`dev-server.js`
```js
const webpackDevServer = require('webpack-dev-server');
const webpack = require('webpack');

const config = require('./webpack.config.js');
const options = {
    contentBase: './dist/assets',
    hot: true,
    host: 'localhost'
};

webpackDevServer.addDevServerEntrypoints(config, options);
const compiler = webpack(config);
const server = new webpackDevServer(compiler, options);

server.listen(5000, 'localhost', () => {
    console.log('dev server listening on port 5000');
});
```

## HRM修改样式表

这也就是之前的`css-loader`和`style-loader`的配置.

值得关注的插件就是`vue-loader`


