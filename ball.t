class Ball
  inherit PhysOb
 
  body proc draw
    var c :int :=mycolour
    if not isMoving() then
      c := gray
    end if
    drawfilloval(floor(position.x),floor(position.y),radius,radius,c)
  end draw
  
 end Ball
