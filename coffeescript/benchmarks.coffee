benchmark = (name, times, fn) ->
  date = new Date()
  for i in [0...times]
    fn()
  console.log "#{name}: #{new Date() - date}"

benchmark "nothing", 1000000, ->

benchmark "just returns", 1000000, ->
  return "qwe"

benchmark "assignment", 1000000, ->
  a = 1

a = ->
benchmark "function call", 1000000, ->
  a()

x = {a: 'b'}
benchmark "dot access", 1000000, ->
  x.a
benchmark "dot access + assignment", 1000000, ->
  a = x.a

benchmark "array creation", 1000000, ->
  []

benchmark "array.push 1", 1000000, ->
  [].push(1)

benchmark "array.push []", 1000000, ->
  [].push([])
