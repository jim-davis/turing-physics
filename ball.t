class Ball
  inherit PhysOb
 
  body proc draw
    var c :int :=mycolour
    if not isMoving() then
      c := gray
    end if
    drawfilloval(floor(position.x),floor(position.y),radius,radius,c)
    if config -> draw_force_vector then
      draw_relative_vector(forces, red)
    end if
    if config -> draw_velocity_vector then
      draw_relative_vector(velocity, grey)
    end if

  end draw

  
 end Ball
