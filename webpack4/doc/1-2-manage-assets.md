---
sidebar: auto
meta:
  - name: manage-assets
    content: manage-assets
prev: ./1-1-setting-up
next: ./1-3-manage-output
---
# manage assets 

## install package 
`yarn add style-loader css-loader --dev`

## add css assets test 

引入`style.css`,并添加到入口点里面.

## 在module里面配置响应的rules
```js
module: {
 rules: [
   {
     test: /\.css$/,
     use: [
       'style-loader',
       'css-loader'
     ]
   }
 ]
}
```
## 加载图片

### install file-loader
`yarn add file-loader --dev`

### webpack.config.js configure

```js
module:{
    rules:[
        {
            test: /\.(png|svg|jpg|gif)$/,
            use: [
                'file-loader'
            ]
        }
    ]
}
```
## 加载字体

### webpack.config.js
```js
{
     test: /\.(woff|woff2|eot|ttf|otf)$/,
     use: [
       'file-loader'
     ]
}
```
### csv-loader & xml-loader

```js
{
 test: /\.(csv|tsv)$/,
 use: [
   'csv-loader'
 ]
},
{
 test: /\.xml$/,
 use: [
   'xml-loader'
 ]
}
```
### 组装全局资源



