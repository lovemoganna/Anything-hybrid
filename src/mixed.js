// @flow

// mixed type
// function getTypeOf(value: mixed): string {
//   return typeof value;
// }

function stringify(value: mixed) {
  // ...
}

stringify('foo');
stringify(3.14);
stringify(null);
stringify({});

// function stringify(value: mixed) {
//   // $ExpectError
//   return `${value}`; // Error!
// }
// stringify('foo');

// 在使用mixed的时候,必须知道你期望的输出类型是什么.
function stringify(value: mixed) {
  if (typeof value === 'string') {
    return `${value}`; // Works!
  }
  return '';
}

stringify('foo');
