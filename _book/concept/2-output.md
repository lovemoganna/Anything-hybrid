
# Table of Contents

1.  [Output](#orgcd07aae)
    1.  [Usage](#orgf55dcb8)
    2.  [Multiple Entry Points](#org7162d05)
    3.  [Advanced](#org58bfed1)


<a id="orgcd07aae"></a>

# Output

配置 `output` 属性就是告诉webpack如何写编译好的文件输出到磁盘.注意,尽管可以设置多个 entry point,但是仅可以有一个 ouput 被指定.


<a id="orgf55dcb8"></a>

## Usage

最小配置如下:

    module.exports = {
      output: {
        filename: 'bundle.js',
      }
    };


<a id="org7162d05"></a>

## Multiple Entry Points

如果你配置创建了多个 `chunk` (因为携带了多个 entry point 或者当你使用 plugins ,比如 CommonsChunkPlugin的时候).

你应该使用 `substitution` (替换) 来确保每个文件都有一个独一无二的名字.

    module.exports = {
      entry: {
        app: './src/app.js',
        search: './src/search.js'
      },
      output: {
        filename: '[name].js',
        path: __dirname + '/dist'
      }
    };
    
    // writes to disk: ./dist/app.js, ./dist/search.js


<a id="org58bfed1"></a>

## Advanced

下面是对 assets使用CND 和 hashes的例子.

    config.js
    ------------------------------
    module.exports = {
      //...
      output: {
        path: '/home/proj/cdn/assets/[hash]',
        publicPath: 'https://cdn.example.com/assets/[hash]/'
      }
    };

在编译时间过程中, outputfile 的 最终 `publicPath` 不知道的情况下, `pubilcPath` 能空着并且动态设置.

    __webpack_public_path__ = myRuntimePublicPath;
    
    // 其余的应用入口

