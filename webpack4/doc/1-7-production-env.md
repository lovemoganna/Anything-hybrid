---
sidebar: auto
meta:
  - name: production environment build 
    content: 生产环境构建
prev: ./1-6-tree-shaking 
next: ./1-8-code-separation
---
# production environment build 

## install webpack-merge 

`npm install --save-dev webpack-merge`

将原先的`webpack-config`拆分为`webpack-common` & `webpack-dev` & `webpack-prod`

`webpack.prod.js`
```js
const webpack = require('webpack');
const merge = require('webpack-merge');
const UglifyJSPlugin = require('uglifyjs-webpack-plugin');
const common = require('./webpack.common.js');

module.exports = merge(common, {
    devtool: 'source-map',
    plugins: [
        new UglifyJSPlugin(
            {sourceMap: true}
        ),
        new webpack.DefinePlugin({
            // 设置在生产环境中构建.
            'process.env.NODE_ENV': JSON.stringify('production')
        })
    ]
});
```
