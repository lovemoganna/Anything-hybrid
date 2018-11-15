---
sidebar: auto
meta:
  - name: build analysis
    content: build analysis
prev: ./2-7-separating manifest
next: ./2-9-performance
---
# build analysis
添加到`package.json`

`"build:stats": "webpack --env production --json > stats.json"`

## 绩效预算

Webpack允许您定义性能预算。这个想法是它给出了你必须遵循的构建大小约束。

默认情况下禁用该功能，并且计算包括提取的块到条目计算。

如果未满足预算并且已将其配置为发出错误，则会终止整个构建。

install `jarvis`,在生产环境中安装.

`Webpack Monitor`是另一个类似的工具，强调清晰的用户界面。

它能够提供有关改进构建的建议。

## 总结

- Webpack允许您提取包含有关构建的信息的JSON文件。数据可以包括构建组成和时间。

- 性能预算允许您设置构建大小的限制。维持预算可以使开发人员更加意识到生成的捆绑包的大小。

- 了解捆绑包是了解如何优化整体规模，加载内容和时间的关键。它还可以揭示更重要的问题，例如冗余数据。


