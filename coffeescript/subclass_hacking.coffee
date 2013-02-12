class Foo
foo = new Foo()

class Foo1 extends Foo
foo1 = new Foo1()

class Foo2 extends foo
  constructor: -> # fails without this.
foo2 = new Foo2()

console.log foo instanceof Foo   # true

console.log foo1 instanceof Foo1 # true
console.log foo1 instanceof Foo  # true

console.log foo2 instanceof Foo2 # true
console.log foo2 instanceof Foo  # false
