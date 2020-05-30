
# Table of Contents

1.  [Dependency Graph](#org6c29903)


<a id="org6c29903"></a>

# Dependency Graph

任意时间一个文件依赖于其他文件,webpack将其视为一个依赖.这允许webpack来携带非代码资产,比如说 images/web fonts,在应用上也可以提供他们作为依赖.

当webpack引导你的应用的时候,它从位于命令行或者它的配置文件的模块列表定义开始.

也就是从 `entry point` 开始,webpack 递归的构建依赖图示,这些图示包含应用中需要的每个模块,接下来将这些模块全部捆绑到少数捆绑包当中.浏览器通常只载入一次.

捆绑应用对于HTTP/1.1 client 相当牛逼,因为在浏览器开始一个新的请求的时候,它最小化了APP的等待时间,

对于 http/2,你可以使用代码切割 来实现比较好的结果.

