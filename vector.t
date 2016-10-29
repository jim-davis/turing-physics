type vector:
  record
    x: real
    y: real
  end record

function vector_invert(v: vector): vector
  var nv: vector
  nv.x := - v.x
  nv.y := - v.y
  result nv
end vector_invert

function getLength(v: vector): real
  result sqrt(v.x ** 2 + v.y ** 2)
end getLength

function vector_copy(v: vector) : vector
  var nv: vector
  nv.x := v.x
  nv.y := v.y
  result nv
end vector_copy

function vector_add(v1: vector, v2: vector) : vector
  var nv: vector
  nv.x := v1.x + v2.x
  nv.y := v1.y + v2.y
  result nv
end vector_add

function vector_difference(v1: vector, v2: vector) : vector
  var nv: vector
  nv.x := v1.x - v2.x
  nv.y := v1.y - v2.y
  result nv
end vector_difference


function vector_distance(v1: vector, v2: vector): real
  result Math.Distance(v1.x, v1.y, v2.x, v2.y)
end vector_distance

function vector_bearing(v1: vector, v2:vector): real
  if v2.y = v1.y then
    if v2.x > v1.x then
      result Math.PI/2
    else
      result -Math.PI/2
    end if
  else
    var dx: real := v2.x - v1.x
    var angle : real := arctan(dx/ (v2.y - v1.y))
    if angle < 0 and dx > 0 then
      angle := angle + Math.PI
    elsif angle > 0 and dx < 0 then
      angle := angle - Math.PI
    end if
    result angle
  end if
end vector_bearing

function vector_str(v: vector): string
  result "[" + realstr(v.x,2) + "," + realstr(v.y,2) + "]"
end vector_str

function make_vector(x: real, y: real) :vector
  var nv : vector
  nv.x := x
  nv.y := y
  result nv
end make_vector

function vector_scalar_multiply (v: vector, s: real) : vector
  var nv : vector
  nv.x := v.x * s
  nv.y := v.y * s
  result nv
end vector_scalar_multiply
