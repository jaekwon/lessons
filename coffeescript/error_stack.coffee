console.log "\nTHROWN ERROR STACK:"
try
  throw new Error('this was thrown')
catch err
  console.log err.stack # prints stack

console.log "\nUNTHROWN ERROR STACK:"
console.log (new Error('this was not')).stack # also prints stack
