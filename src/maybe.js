// @flow
function acceptsMaybeNumber(value: ?number) {
  // ...
}

acceptsMaybeNumber(42); // Works!
acceptsMaybeNumber(); // Works!
acceptsMaybeNumber(undefined); // Works!
acceptsMaybeNumber(null); // Works!
// acceptsMaybeNumber('42'); // Error!

function acceptsMaybeProp({ value }: { value: ?number }) {
  // ...
}

acceptsMaybeProp({ value: undefined }); // Works!
// acceptsMaybeProp({}); // Error!

function acceptsMaybeNumber(value: ?number) {
  if (value !== null && value !== undefined) {
    return value * 2;
  }
}
acceptsMaybeNumber(2);

// @flow
function acceptsMaybeNumber2(value: ?number) {
  if (typeof value === 'number') {
    return value * 2;
  }
}
acceptsMaybeNumber2(3);
