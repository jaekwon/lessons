printme = (args...) ->
  console.log "{#{args}}"

returnme = (args...) ->
  return "<#{args}>"

# the following comma sequences are OK in coffeescript.
# most other possibilities result in wrong parsing.
# not sure how to make this less error-prone.

printme '',               # arg 0
  returnme "a",           # arg 1
    returnme "a.a"
    returnme "a.b"
  if true                 # arg 2
    returnme "b",
      returnme "b.a",
        returnme "b.a.a"
        returnme "b.a.b"
      returnme "b.b"
  else
    returnme "~b",
      returnme "~b.a"
  for c in 'cde'          # arg 3,4,5
    returnme c,
      returnme "#{c}.a"
      returnme "#{c}.b"
