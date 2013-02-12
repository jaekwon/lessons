GLOBAL.toString = -> 'GLOBAL'

class Foo
  constructor: (a, b) ->
    #console.log a, b
  foo: =>
    @
  toString: -> '<Foo>'

class Bar extends Foo
  constructor: (a, b, c) ->
    #console.log a, b, c
    #super(a, b)
  bar: =>
    @
  toString: -> '<Bar>'
    
f = new Foo()
foo = f.foo
console.log ''+foo() # <Foo>

b = new Bar()
foo = b.foo
console.log ''+foo() # GLOBAL, because 'super' wasn't called.
