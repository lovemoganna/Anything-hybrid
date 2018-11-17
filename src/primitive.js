/* @flow */
function acceptNumber(value: number) {
  console.log(value);
}

acceptNumber(Infinity);
acceptNumber(NaN);

'foo' + 'foo'; // Works!
`foo${String({})}`; // Works!
`foo${[].toString()}`; // Works!
`${JSON.stringify({})}`; // Works!

function acceptsNull(value: null) {
  /* ... */
}
function acceptsUndefined(value: void) {
  /* ... */
}
acceptsNull(null); // Works!
// acceptsNull(undefined); // Error!
// acceptsUndefined(null);      // Error!
acceptsUndefined(undefined); // Works!

function acceptsMaybeString(value: ?string) {
  // ...
}
acceptsMaybeString('bar'); // Works!
acceptsMaybeString(undefined); // Works!
acceptsMaybeString(null); // Works!
acceptsMaybeString(); // Works!


function acceptsObject(value: { foo?: string }) {
  // ...
}
acceptsObject({ foo: 'bar' }); // Works!
acceptsObject({ foo: undefined }); // Works!
// acceptsObject({ foo: null }); // Error!
acceptsObject({});

function acceptsOptionalString(value: string = 'foo') { /* ... */ }
acceptsOptionalString('bar'); // Works!
acceptsOptionalString(undefined); // Works!
// acceptsOptionalString(null);      // Error!
acceptsOptionalString(); // Works!
