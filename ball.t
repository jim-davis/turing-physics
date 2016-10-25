
class Ball
  inherit PhysOb
 
  
  body proc draw
    var c :int :=mycolour
    if not isMoving() then
      c := gray
    end if
    drawfilloval(floor(x),floor(y),radius,radius,c)
  end draw
  
  body proc hide
    drawfilloval(floor(x),floor(y),radius,radius,white)
  end hide
end Ball
