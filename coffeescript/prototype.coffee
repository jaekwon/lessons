A = {foo: 'bar'}
B = ->
B.prototype = A
b = new B()
console.log b.foo # 'bar'
