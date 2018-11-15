---
sidebar: auto
meta:
  - name: tree shaking 
    content: tree shaking 
prev: false
next: false
---
# tree shaking 

作用就是如果可以静态地分析模块定义而不运行它，webpack可以告诉代码的哪些部分正在使用，哪些部分不使用.

## test shaking 

使用`npm run build -- --display-used-exports`来查看结果.

您应该在终端中看到[no exports used]或输出其他输出[only some exports used: bake]

![](https://upload-images.jianshu.io/upload_images/7505161-4a038435a8079001.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

