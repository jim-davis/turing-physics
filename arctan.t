


for i : 0..7
  var angle : real := i * Math.PI / 4
  var t : real := tan (angle)
  put "angle = ", angle, " tan = ", t, " arctan = ", arctan (t)
end for

put skip 
for i : 0..7
  var angle : real := -i * Math.PI / 4
  var t : real := tan (angle)
  put "angle = ", angle, " tan = ", t, " arctan = ", arctan (t)
end for
