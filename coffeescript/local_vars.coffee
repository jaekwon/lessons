local = (fn) -> fn()

foo = 'a global!'

local (foo, bar) =>
  foo = 'a local!'
  console.log foo # a local!

console.log foo # a global!
