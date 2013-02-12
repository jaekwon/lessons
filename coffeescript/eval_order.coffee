# Function calls without parentheses gets evaluated right->left,
# with or without commas.

a = (args...) ->
  "<a:#{args}>"

b = (args...) ->
  "(b:#{args})"

c = (args...) ->
  "[c:#{args}]"

console.log a b c "d", "e", "f"
# <a:(b:[c:d,e,f])>

console.log a b "B", c "d", "e"
# <a:(b:B,[c:d,e])>
