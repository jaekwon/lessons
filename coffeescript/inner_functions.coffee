foo = ->
  return ->
    "func"
f1 = foo()
f2 = foo()
console.log f1 == f2
console.log f1 is f2
