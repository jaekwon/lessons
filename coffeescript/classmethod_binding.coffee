GLOBAL.toString = -> "GLOBAL"

B = (fn) ->
  fn.bindMethod = true
  fn

class Foo

class Bar extends Foo

  bound:B ->
    return @

  unbound: ->
    return @

  for own name, value of (@::) when typeof value is 'function' and value.bindMethod then do (name, value) =>
    Object.defineProperty @::, name, enumerable: false, configurable: true, get: ->
      if @.hasOwnProperty 'constructor'
        return value
      else
        return @[name] = value.bind @
    , set: (newValue) ->
        Object.defineProperty @, name, value: newValue

b = new Bar()
Bar_bound = Bar::bound
b_bound = b.bound
Bar_unbound = Bar::unbound
b_unbound = b.unbound

console.log ''+Bar::bound()
console.log ''+Bar_bound()
console.log "B:", b
console.log ''+b.bound()
console.log ''+b_bound()

console.log ''+Bar::unbound()
console.log ''+Bar_unbound()
console.log ''+b.unbound()
console.log ''+b_unbound()

class Baz extends Bar
  bound: ->
    return @

z = new Baz()
Baz_bound = Baz::bound
z_bound = z.bound
console.log ''+Baz::bound()
console.log ''+Baz_bound()
console.log ''+z.bound()
console.log ''+z_bound()
