# This is an exercise in CoffeeScript metaprogramming with instance-bound methods.

class Foo1
  bar: =>            # A typical instance-bound method.
    console.log this # Will print the Foo1 instance.

  constructor: ->
    "constructor1"

class Foo2
  this::['bad'] = => # This won't work!
    console.log this # `this` gets translated to console.log(Foo2)
  this::['bar'] = -> # This doesn't work until `this` gets bound manually in the constructor
    console.log this

  constructor: ->
    this.bad = this.bad.bind(this) # Doesn't achieve anything.
    this.bar = this.bar.bind(this) # This works!
    "constructor2"

f1 = new Foo1()
f2 = new Foo2()

test = {'name': 'test'}
test.f1bar = f1.bar
test.f2bad = f2.bad
test.f2bar = f2.bar

test.f1bar() # "{ bar: [Function] }"
test.f2bad() # "[Function: Foo2]"
test.f2bar() # "{ bad: [Function], bar: [Function] }"
