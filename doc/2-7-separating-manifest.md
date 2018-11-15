---
sidebar: auto
meta:
  - name: separating manifest
    content: separating manifest 
prev: ./2-6-environment-variable
next: ./2-8-build-analysis
---

# separating manifest 

当webpack写入bundle时，它也会保留一个清单(manifest).

清单描述了webpack应该加载的文件。

可以提取它并开始加载项目文件，而不必等待加载供应商包。

如果哈希webpack生成更改，则清单也会更改。结果，供应商包的内容发生变化，并变为无效。

通过将清单提取到自己的文件或将其内联写入项目的index.html，可以消除该问题。

## 提取清单

```js
runtimeChunk: {
    name: "manifest"
}
```
![](https://upload-images.jianshu.io/upload_images/7505161-687cc49c262a5e20.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

在上面的输出中，它已标记为manifest块名称。

因为设置正在使用HtmlWebpackPlugin，所以无需担心自己加载清单，因为插件添加了对index.html的引用.

## 使用记录
`AggressiveSplittingPlugin`使用记录来实现缓存。

记录允许您跨构建存储模块ID。作为缺点，您必须跟踪记录文件。

添加到`production`环境里面.
```js
recordsPath: path.join(__dirname, "records.json"),
```
