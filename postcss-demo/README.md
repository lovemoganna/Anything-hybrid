## 混合式开发

由于网络环境实在坑爹,与远程服务器协同工作.github充当中转站.

## 添加公钥

`ssh-keygen -t rsa -f ~/.ssh/id_rsa_gitee_one -C "gitee-user1@email.com"`

[链接](https://www.jianshu.com/p/d195394f7d2e)

## git添加远程仓库
从远程拉取仓库,`git remote -v`

1.`git clone xxxx`,查看远程仓库的信息`git remote`

2.添加远程库并给这个仓库起别名叫`pb`,`git remote add pb git://github.com/paulboone/ticgit.git`

3.拉取远程的更新提交,`git fetch pb`

4.自己push的时候,使用`git push pb master`

5.自己看远程仓库的信息` git remote show `

## 安装
`npm i -D postcss-preset-env postcss-import pug pug-loader  pug-plain-loader
`

## 故障处理

nvm切换node版本.由`10`切到`8.9`,这下舒服了.

`mw1200`

## vue-cli3的静态资源默认的配置

由于静态资源采用相对路径的方式不支持了.所以不要找虐.直接重新配置一个完整的项目.观察他的默认配置.

![](https://upload-images.jianshu.io/upload_images/7505161-9400b8a72f52c281.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

也就是在`public/img/`下面放置静态图片.目前CSS没动,木有发现问题.

## 终极形态

google搜索,`vue-cli-plugin-xxx`or use `@vue/cli-plugin-xxx`搜索插件.

插件的安装方式,比如`vue add vuetify-vuetify`这个插件,安装命令就是`vue add vuetify`

这个插件有一大堆设置: 反正就是图标我加了.你自己去看看吧.支持中文.`customer` 的选项没选.别的随便.

安装完了 这个插件,你会发现换了一身皮.

还没完.接着安装`npm i axios --save`









