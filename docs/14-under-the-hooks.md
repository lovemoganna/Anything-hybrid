
# Table of Contents

1.  [under the hooks](#org3493825)
2.  [the mainparts](#org28249aa)
3.  [Chunks](#orgff9609a)


<a id="org3493825"></a>

# under the hooks

捆绑过程是一个带来一些文件和发射其他文件的函数.


<a id="org28249aa"></a>

# the mainparts

-   index.js
-   app.js

要是用它们,模块来自(ModuleGraph)

在捆绑进程期间,模块包含在chunks里面.

Chunks包含在来自 通过模块互相连接ChunkGraph 的Chunk groups里面.

当你描述一个入口点的时候,在hood下面,你创建了带有chunk的chunk group.


<a id="orgff9609a"></a>

# Chunks

-   initial
-   entry: index.jsx / index.js
-   output: main.js
-   output.filename

-   non-initial

output.chunkFilename

[id]
[name]
[contenthash]

