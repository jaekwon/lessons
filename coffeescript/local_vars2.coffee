{log, sin, cos, tan, PI} = Math
local = (fn) -> fn()

myCos = (theta) ->
  local (cos) ->
    cos = sin(PI/2 - theta)

console.log myCos(PI/3) # 0.5
console.log cos         # [Function: cos]
