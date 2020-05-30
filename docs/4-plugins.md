
# Table of Contents

1.  [Plugins](#org1010443)
    1.  [Anatomy(解析)](#orgbd5896c)
    2.  [Usage](#org4c81969)
    3.  [Configuration](#orga3dd3fd)
    4.  [NODE API](#orgfbd4694)


<a id="org1010443"></a>

# Plugins

Plugin 是 webpack里面的骨干.


<a id="orgbd5896c"></a>

## Anatomy(解析)

webpack plugin 是一个 JS 对象,有 apply方法.

这个apply方法在webpack编译的时候被调用,给予整个编译生命周期的访问.

1.  `ConsoleLogOnBuildWebpackPlugin.js`


<a id="org4c81969"></a>

## Usage

因为plugin 可以携带 arguments/options,你必须给 `plugins` 属性传递一个新的实例.


<a id="orga3dd3fd"></a>

## Configuration

    const HtmlWebpackPlugin = require('html-webpack-plugin'); //installed via npm
    const webpack = require('webpack'); //to access built-in plugins
    const path = require('path');
    
    module.exports = {
      entry: './path/to/my/entry/file.js',
      output: {
        filename: 'my-first-webpack.bundle.js',
        path: path.resolve(__dirname, 'dist')
      },
      module: {
        rules: [
          {
    	test: /\.(js|jsx)$/,
    	use: 'babel-loader'
          }
        ]
      },
      plugins: [
        new webpack.ProgressPlugin(),
        new HtmlWebpackPlugin({template: './src/index.html'})
      ]
    };


<a id="orgfbd4694"></a>

## NODE API

Using `plugin` configuration it.

