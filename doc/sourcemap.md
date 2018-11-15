## sourcemap

- sourcemap在开发和生产过程中都很有用。它们提供有关正在发生的事情的更准确信息，并使调试可能出现的问题变得更快。
- Webpack支持各种源映射变体。它们可以根据生成位置拆分为内联和单独的源映射。由于速度的原因，内联源映射在开发过程中很方便。单独的源映射适用于生产，然后加载它们变为可选。
- devtool: "source-map" 是最高质量的选择，使其对生产有价值。
- cheap-module-eval-source-map 是一个很好的发展起点。
- 如果您想在生产过程中只获得堆栈跟踪，请使用devtool: "hidden-source-map"。您可以捕获输出并将其发送到第三方服务供您检查。这样您就可以捕获错误并修复它们。
- SourceMapDevToolPlugin并EvalSourceMapDevToolPlugin提供比devtool快捷方式更多的结果控制。
- 如果您的依赖项提供源映射，source-map-loader可以派上用场。
- 为样式设置源图需要额外的努力。您必须为sourceMap正在使用的每个样式相关的加载器启用选项。

## bundle splitting

就现在来说,应用程序的生产版本是单个JS文件,只要应用程序发生更改,则客户端就必须下载相应的`vendor dependencies`

我们期望的是只下载更改的部分.所以`bundle split`可以做到这一点.

所以在生产模式下运行时.捆绑分裂使用
```js
optimization.splitChunks.cacheGroups
```

## bundle splitting 的思想

通过捆绑拆分,你可以将相应的供应商依赖项 推送到自己的捆绑包,并从客户端级别的缓存中获得便利.

但是随着执行请求越多,可能性能会有一些问题.但是缓存的存在可以消除一些影响.

## 拆分测试

添加`npm install react react-dom --save`

![](https://upload-images.jianshu.io/upload_images/7505161-c6f0d6a99a728d26.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

现在`main.js`有点大.下面我们就给他进行捆绑拆分.分离很久都不会改变的`react`依赖.

webpack.config.js.bak

```js
const productionConfig = merge([
  ...

  {
    optimization: {
      splitChunks: {
        chunks: "initial",
      },
    },
  },

]);
```
![](https://upload-images.jianshu.io/upload_images/7505161-9c9e441b7a2f3b41.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

所以你看上面的`main.js`大小 = 现在的`main.js`大小 + 分裂出的`vendors~main.js`大小.

`116 = 8.89 + 108 = 116.89`

基本思想如下:

应用配置后的app 和 ventor bundle package 

![](https://survivejs.com/cc11f7e53c579fff28de1b3ed5b9f53a.png)

## control bundle split

可以使用针对node_modules的显式测试重写上面的配置

webpack.config.js.bak
```js
const productionConfig = merge([
  ...

  {
    optimization: {
      splitChunks: {
        cacheGroups: {
          commons: {
            test: /[\\/]node_modules[\\/]/,
            name: "vendor",
            chunks: "initial",
          },
        },
      },
    },
  },

]);
```

如果不希望依赖自动化，则使用此格式可以更好地控制拆分过程。

![](https://upload-images.jianshu.io/upload_images/7505161-7bc98ebc0f740c62.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

效果跟上面一样.

## 拆分和合并块

Webpack通过两个插件提供对生成的块的更多控制:

`AggressiveSplittingPlugin`和`AggressiveMergingPlugin`,名字就叫做激进分裂.

前者允许您发出更多和更小的包。由于新标准的工作方式，HTTP / 2的行为很方便。

激进分裂的基本思路:

```js
{
  plugins: [
    new webpack.optimize.AggressiveSplittingPlugin({
        minSize: 10000,
        maxSize: 30000,
    }),
  ],
},
```
积极的合并插件以相反的方式工作，并允许您将小包组合成更大的：

```js
{
  plugins: [
    new AggressiveMergingPlugin({
        minSizeReduce: 2,
        moveToParents: true,
    }),
  ],
},
```
## Chunks Types of webpack 

- entry chunks: 条目块包含webpack运行时和它随后加载的模块
- normal chunks: 正常块不包含webpack运行时。相反，这些可以在应用程序运行时动态加载。为这些生成合适的包装器.
- initial chunks: 初始块是正常的块，计入应用程序的初始加载时间。这是入口块和正常块之间的分离，这很重要。
