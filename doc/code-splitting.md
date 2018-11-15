---
sidebar: auto
meta:
  - name: code splitting 
    content: code splitting 
prev: false
next: false 
---

# code splitting 

代码拆分,最大的特点就是在有需要的时候懒加载代码.

webpack的延迟加载可以实现Google的PRPL模式。PRPL（推送，渲染，预缓存，延迟加载）的设计考虑移动网络。

## 代码拆分的格式

主要由2中方式完成:
- import(用于项目里面)
- require.ensure语法

拆分中可以有拆分，可以根据拆分构建整个应用程序。目标是最终得到一个按需加载的分裂点。

这样做的好处是，您的应用程序的初始有效负载可能会比其他情况下更小。

![](https://survivejs.com/d0157e4db2b71adc9a7a25316309c3d1.png)

## dynamic import

界面允许组合，您可以并行加载多个资源:

```js
Promise.all([
  import("lunr"),
  import("../search_index.json"),
]).then(([lunr, search]) => {
  return {
    index: lunr.Index.load(search.index),
    lines: search.lines,
  };
});
```
## 设置代码拆分

使用`动态的import`.需要添加`babel`的设置.

`npm install @babel/plugin-syntax-dynamic-import --save-dev`

`lazy.js`
```js
export default 'Hello from lazy';
```
`component.js`
```js
export default (text = 'Hello Purecss!') => {
  const element = document.createElement('div');
  element.className = 'pure-button';
  element.innerHTML = text;
  // 通过动态导入,然后promise的风格来拆分代码
  element.onclick = () =>
        import('./lazy')
            .then((lazy) => {
              element.textContent = lazy.default;
            })
            .catch((err) => {
              console.error(err);
            });
  return element;
};
```
然后就实现了延迟加载.

![](https://upload-images.jianshu.io/upload_images/7505161-abc9b611eac948ff.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

构建里面出现了`2.js`,这就是那个分裂点.检查文件显示webpack已将代码包装在一个webpackJsonp块中并处理了代码位.

>如果要调整块的名称，请进行设置output.chunkFilename。例如，将其设置为"chunk.[id].js"将为每个拆分块添加单词“chunk”。

## 总结
- 要使用动态import语法，Babel和ESLint都需要仔细调整。Webpack支持开箱即用的语法.
- 使用命名将单独的拆分点拉入相同的包中。
- 要禁止代码分裂，使用webpack.optimize.LimitChunkCountPlugin与maxChunks设置为1。
