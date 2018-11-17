// 使用any不安全
// @flow
function add(one: any, two: any): number {
  return one + two;
}

add(1, 2); // Works.
add('1', '2'); // Works.
add({}, []); // Works.
