// @flow
function acceptsTwo(value: 2) {
  // ...
}
acceptsTwo(2); // Works!
// $ExpectError
// acceptsTwo(3);   // Error!
// $ExpectError
// acceptsTwo("2"); // Error!
// @flow
function getColor(name: "success" | "warning" | "danger") {
  switch (name) {
    case 'success': return 'green';
    case 'warning': return 'yellow';
    case 'danger': return 'red';
  }
}

getColor('success'); // Works!
getColor('danger'); // Works!
// $ExpectError
// getColor("error");   // Error!
