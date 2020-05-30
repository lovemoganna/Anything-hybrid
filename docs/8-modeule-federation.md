
# Table of Contents

1.  [Module Federation](#orgb60be07)
    1.  [Motivation(动机)](#org456747b)
    2.  [Low level concepts](#org2e7c886)
    3.  [Overriding](#org839e00c)
    4.  [High-level concepts](#org601d22f)
    5.  [Building blocks](#org2728bb5)
    6.  [Concept goals](#org83ad873)
2.  [Use Cases](#org80b1386)
    1.  [Separate builds per page](#orga5c3c11)
    2.  [Components library as container](#org814e1e9)


<a id="orgb60be07"></a>

# Module Federation


<a id="org456747b"></a>

## Motivation(动机)

应该从单一应用中进行多个分离构建.

这些分离构建彼此不必相互依赖,所以它们可以单独的被部署和构建.


<a id="org2e7c886"></a>

## Low level concepts

我们区分local 和 remote 模块.

local 模块是正常的模块,即当前构建的一部分.

remote模块 不是当前构建的一部分,它来自于容器,在运行时被载入.

载入到远程模块被视为异步操作.当我们使用一个远程模块的时候,这个异步操作会被替代.这出现在下一个组块载入操作系统中的时候.

没有组块正在载入操作系统,它是不可能使用远程模块的.

一个chunk 载入操作系统通常使用 `import()` 调用,但是 旧版结构像 `require.ensure` or `require([...])` 也被支持.

container 通过 container entry 来创建, container entry 公开异步访问到指定模块.这种公开访问分为 2个步骤:

1.  异步载入这个模块.
2.  同时评估这个模块.

步骤1 在 chunk 载入的期间完成,步骤 2在和其他(local/remote) 模块交叉评估的过程中完成.

这种方式下,从 local 到 remote 来(或者其他方式)来转换一个模块,评估顺序是不受影响的,

嵌套一个container是有可能的.Containers 可以从其他Containers使用模块.

容器之间的循环依赖也是可能的.


<a id="org839e00c"></a>

## Overriding

Container 可以标记选定的local模块成为 "overridable" (可被覆写的).

container 的消费者可以提供 "overrides" (方法重载),这可以让模块替换容器中的 override 模块组中的一个.

只要消费者提供 方法重载, container 中的所有模块都可以使用可替换的模块,来替代 local module.

但消费者若不提供一个替换模块,container中的所有模块将使用本地模块.

Container 管理 override 模块, 这种方式是: 当模块通过消费者被覆写的时候,这些模块不需要被下载.通过在分离的chunk中来放置替换模块.

另外一方面,替换模块的提供者,只提供 异步载入函数.它允许  container 来载入替换模块(只是它们在需要的情况下).

提供者将会管理替换模块,它们不通过container请求,所以它们不必被下载.通过在分离的chunk中来放置替换模块.

一个 "name" 被用于校验来自 container 的覆写模块.

容器 exposes (公开) 模块的时候,以一种类似的方式提供覆写,分为两个步骤:

1.  loading (异步)
2.  evaluating (异步)

当嵌套使用的时候,在嵌套的containers中,给一个container提供覆写 将会自动覆写这些模块.

    在容器中的模块被载入之前覆写必须被提供.
    
    可覆盖对象在初始化 chunk 被使用,只可以通过同步模块覆写方式来进行覆盖.不能使用promise.
    
    一旦评估,可覆盖对象就不能被覆写了.


<a id="org601d22f"></a>

## High-level concepts

每个构建动作都充当容器,消耗其他构建也会充当容器.

每一次构建,通过从它的容器载入,可以访问任何其他公开模块.


<a id="org2728bb5"></a>

## Building blocks

OverridablesPlugin [low level]

这个plugin 让指定的模块 "override". A local API (<span class="underline"><span class="underline">webpack<sub>override</sub></span></span>) 允许提供 *overrides*

    //  webpack.config.js
    //  -------------------------------------
    const OverridablesPlugin = require('webpack/lib/container/OverridablesPlugin');
    module.exports = {
      plugins: [
        new OverridablesPlugin([
          {
    	// we define an overridable module with OverridablesPlugin
    	test1: './src/test1.js',
          },
        ]),
      ],
    };

    //  src/index.js
    // -------------------------------
    __webpack_override__({
      // here we override test1 module
      test1: () => 'I will override test1 module under src',
    });

-   ContainerPlugin[low level]
-   ContainerReferencePlugin [low level]
-   ModuleFederationPlugin[high level]


<a id="org83ad873"></a>

## Concept goals

-   应该尽可能的公开和使用webpack支持的任何模块类型
-   Chunk 载入的过程中应该载入并行过程需要的一切.(到服务器的单个往返)

-   控制消费者到容器
-   覆写模块是一个定向操作
-   Sibling Containers 不能覆写彼此间的其他模块.

-   Concept 应该环境独立

1.可用的web,nodejs,etc


<a id="org80b1386"></a>

# Use Cases


<a id="orga5c3c11"></a>

## Separate builds per page

从容器里分离构建的单页面应用的每一页都是公开的.

这个应用shell也是作为remote module来分离构建引用所有的页面.

这样每一页都能被分别部署.这个应用shell通常使用库来定义,作为共享modules来避免页面构建中重复.


<a id="org814e1e9"></a>

## Components library as container

很多应用共享一个 common components 库,这个库可以被构建成每个组件公开的container.

每个应用的消费组件来自于组件库容器.

改变组件库可以分别部署,而不需要重新发布应用.这个应用自动使用组件库的升级版本.

