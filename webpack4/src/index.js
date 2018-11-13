import _ from 'lodash';
import printMe from './print.js';
import "./style.css"
function component() {
    var element = document.createElement('div');
    var btn = document.createElement('button');
    // Lodash, now imported by this script
    element.innerHTML = _.join(['hello', 'webpack'], ' ');
    btn.innerHTML = 'Click me and check the console!';
    btn.onclick = printMe;
    element.appendChild(btn);
    return element;
}

// document.body.appendChild(component());
let element = component();
document.body.appendChild(element);
//当 print.js 内部发生变更时可以告诉 webpack 接受更新的模块
if (module.hot) {
    module.hot.accept('./print.js', function () {
        console.log('Accepting the updated printMe module!');
        // printMe();
        document.body.removeChild(element);
        element = component(); // 重新渲染页面后，component 更新 click 事件处理
        document.body.appendChild(element);
    })
}
