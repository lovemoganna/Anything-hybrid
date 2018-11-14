---
sidebar: auto
meta:
  - name: lazy load
    content: lazy load
prev: ./1-8-code-separation
next: false
---

# lazy load 

## index.js

```js
import _ from 'lodash';

function component() {
    var element = document.createElement('div');
    var button = document.createElement('button');
    var br = document.createElement('br');

    button.innerHTML = 'Click me and look at the console!';
    element.innerHTML = _.join(['Hello', 'webpack'], ' ');

    element.appendChild(br);
    element.appendChild(button);
    button.onclick = e => import(/* webpackChunkName: "print" */ './print').then(module => {
        var print = module.default;
        print();
    });
    return element;
}
document.body.appendChild(component());
```
## 查看

点击按钮,查看`network`,才会加载`print.bundle.js`.这就是懒加载.
