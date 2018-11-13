import _ from 'lodash';
import './style.css';
import Icon from '../asets/img/w2.jpg'
import Data from './data.xml';

function component() {
    var element = document.createElement('div');

    // Lodash, now imported by this script
    element.innerHTML = _.join(['马', '牛'], ' ');
    element.classList.add('hello');

    var myIcon = new Image();
    myIcon.src = Icon;
    element.appendChild(myIcon);

    console.log(Data)
    return element;
}

document.body.appendChild(component());
