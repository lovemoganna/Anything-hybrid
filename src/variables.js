// var - 声明一个变量，可选择赋值。
// let - 声明一个块范围的变量，可选择赋值。（MDN）
// const - 声明一个块范围的变量，分配一个无法重新赋值的值

/* @flow */
let varVariable = 1;
let letVariable = 1;
// const constVariable = 1;

varVariable = 2; // Works!
letVariable = 2; // Works!
// $ExpectError
// constVariable = 2; // Error!

const foo /* : number */ = 1;
const bar: number = 2;

const fooVar /* : number */ = 1;
const fooLet /* : number */ = 1;
const barVar: number = 2;
const barLet: number = 2;

let foo2: number = 1;
foo2 = 2; // Works!
// $ExpectError
// foo = '3'; // Error!

let foo3 = 42;

if (Math.random()) foo3 = true;
if (Math.random()) foo3 = 'hello';

const isOneOf: number | boolean | string = foo3; // Works!

let foo4 = 42;
const isNumber: number = foo4; // Works!

foo4 = true;
const isBoolean: boolean = foo4; // Works!

foo4 = 'hello';
const isString: string = foo4; // Works!


// @flow
let foo = 42;

function mutate() {
  foo = true;
  foo = 'hello';
}

mutate();

// $ExpectError
// let isString: string = foo; // Error!
