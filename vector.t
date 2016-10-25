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
