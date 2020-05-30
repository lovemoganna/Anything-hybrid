# Entry

`Entry` 属性,有多种方式来定义.

## Single Entry{速记} 语法

Usage: entry: string | [string]

    module.exports = {
      entry: './path/to/my/entry/file.js'
    };

对于 `entry` 属性 ,单个 entry 语法可简记为:

    module.exports = {
      entry: {
        main: './path/to/my/entry/file.js'
      }
    };

当你给 `entry` 传递数组的时候会发生什么?

    在给 =entry= 属性 传递一个文件路径数组过程中,会创建视为 =multi-main entry=.
    当你想一起注入多个依赖文件,并且图形化它们的依赖到一个 =chunk= (组块)当中,这是非常有用的.

这个方式并不是特别灵活.


<a id="orge35708f"></a>

## Object Syntax

Usage: entry: { <entryChunkName> string | [string] }

```js
    //webpack.config.js
    //--------------------------------------------
     module.exports = {
       entry: {
         app: './src/app.js',
         adminApp: './src/adminApp.js'
       }
     };
```
这个 object syntax 更加冗余,但这是在应用中定义 `entry/entries` 最具拓展性的方式.

`Scalable webpack configuration` 是一种可以重用和包含其他不完整的配置.

这是一种受欢迎的技术,通过 `environment / build target/ runtime` 被用于分离关注事项.他们也可以通过特殊工具来合并起来,比如使用 `webpack-merge`.


<a id="org82098f4"></a>

# Scenarios(情境)


<a id="orge00cdb1"></a>

## Separate APP and Vendor(供应商) Entries

这主要有 3个文件

-   webpack.config.js

    module.exports = {
      entry: {
        main: './src/app.js',
        vendor: './src/vendor.js'
      }
    };

-   webpack.prod.js (生产环境的配置)

    module.exports = {
      output: {
        filename: '[name].[contentHash].bundle.js'
      }
    };

-   webpack.dev.js (开发环境的配置)

    module.exports = {
      output: {
        filename: '[name].bundle.js'
      }
    };

现在的情况就是,我们告诉webpack.

有2个分离的入口点,为毛这么干哪,

JS里面有很多库,妈的,有些库你不必管它. 给你弄个 `threeJS` 的库,估计每个10天半个月也看不懂.所以把这些库看成死物.放在 `vendor.js` 里面就可以了.
它们将会捆绑在一起,然后放到它们的(组块) chunk当中.

`-content hash` 是一样的,允许浏览器单独缓存它们,从而减少载入的时间.

-   main: `app.js`
-   vendor: `vendor.js` // 放一些 JQUERY/THREEJS/BOOTSTRAP 的库.

webpack4 版本以下,通常添加 `vendor` 作为 separate entry point 来编译它作为 separate file.(与 CommonsChunkPlugin 相结合).

webpack4 不建议这么做, `optimization.splitChunks` option 关心 separating vendors and app modules, AND creating a separate file.

所以不必为一个vendors 或其他东西 创建一个 entry了,这也不是执行操作的起点.


<a id="org70c3a25"></a>

# Multi Page Application

    module.exports = {
      entry: {
        pageOne: './src/pageOne/index.js',
        pageTwo: './src/pageTwo/index.js',
        pageThree: './src/pageThree/index.js'
      }
    };

这样就是告诉 webpack 我们想有 3个分离的依赖图示.

在单页面应用中,服务器在为你 fetch一个新的HTML document过程中,这个页面会重载 新的document , assets 会被重新下载.

这给我们唯一的选择来做这件事情,比如说使用 `optimization.splitChunks` 来创建捆绑包,从而在每个页面间的分享应用代码.

Multi-Page 应用随着 entry point 的数量增加,可以在entry point 之间可以重复使用大量的代码 和 模块,受到了这项技术的巨大益处.

