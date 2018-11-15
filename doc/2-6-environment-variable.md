---
sidebar: auto
meta:
  - name: envionment variable 
    content: environment variable
prev: ./2-5-tree-shaking 
next: false
---
# environment variable 
Webpack 4 是通过`process.env.NODE_ENV`给定模式设置.

## DefinePlugin 的基本思想

```js
var foo;

// Not free due to "foo" above, not ok to replace
if (foo === "bar") {
  console.log("bar");
}

// Free since you don't refer to "bar", ok to replace
if (bar === "bar") {
  console.log("bar");
}
```
```js
var foo;

// Not free due to "foo" above, not ok to replace
if (foo === "bar") {
  console.log("bar");
}

// Free since you don't refer to "bar", ok to replace
if ("foobar" === "bar") {
  console.log("bar");
}
```
```js
var foo;

// Not free due to "foo" above, not ok to replace
if (foo === "bar") {
  console.log("bar");
}

// Free since you don't refer to "bar", ok to replace
// false代码块,可以直接删除.
if (false) {
  console.log("bar");
}
```
## 设置 process.env.NODE_ENV
set file path 

```text
.
└── store
    ├── index.js
    ├── store.dev.js
    └── store.prod.js
```
`index.js`
```js
if (process.env.NODE_ENV === "production") {
  module.exports = require("./store.prod");
} else {
  module.exports = require("./store.dev");
}
```
