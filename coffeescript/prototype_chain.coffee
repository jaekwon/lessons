class Foo
  m1: 'Foo.m1'
  m2: 'Foo.m2'

class Bar extends Foo
  m2: 'Bar.m2'
  m3: 'Bar.m3'

console.log Foo::m1 # Foo.m1
console.log Foo::m2 # Foo.m2
console.log Foo::m3 # undefined

console.log Bar::m1 # Foo.m1
console.log Bar::m2 # Bar.m2
console.log Bar::m3 # Bar.m3
