# You can't just extend native classes.

class NotAnArray extends Array
  toString: ->
    this.join(',')

# prints nothing.
for x in (new NotAnArray(1,2,3))
  console.log x

# prints 1\n2\n3
for x in (new Array(1,2,3))
  console.log x
