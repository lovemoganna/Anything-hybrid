---
sidebar: auto
meta:
  - name: code separation 
    content: code separation
prev: ./1-7-production-env
next: false
---
# code separation 

## 入口点

`webpack.config.js`

现在使用`splitChunks`

```js
 optimization: {
        splitChunks: {
            cacheGroups: {
                defaul: false,
                vendor: false,
            }
        }
    }
```

## 动态导入
```js
    output: {
        filename: '[name].bundle.js',
        chunkFilename: '[name].bundle.js',
        path: path.resolve(__dirname, 'dist'),
    },
```
这里使用了 chunkFilename，它决定非入口 chunk 的名称。

`index.js`
```js
function getComponent() {
    return import(/* webpackChunkName: "lodash" */ 'lodash').then(_ => {
        var element = document.createElement('div');
        element.innerHTML = _.join(['Hello', 'webpack'], ' ');
        return element;
    }).catch(error => 'An error occurred while loading the component');
}

getComponent().then(component => {
    document.body.appendChild(component);
});
```
现在，我们不再使用静态导入 lodash，而是通过使用动态导入来分离一个 chunk.

在注释中使用了 webpackChunkName。这样做会导致我们的 bundle 被命名为 lodash.bundle.js ，而不是 [id].bundle.js 。

`通过 async 函数简化代码`

```js

```



