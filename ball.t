
class Ball
  inherit PhysOb
  body proc step (seconds: real)
    var fx,fy: real
    fx:=0
    fy:=0
    if geometry = WRAP then
      if x  < 0 then
	x := maxx
      elsif x  > maxx then
	x := 0
      end if
      if y  < 0 then
	y := maxy 
      elsif y  > maxy then
	y := 0
      end if
    elsif geometry = BOUNCE then
      % collision with walls.  Walls have infinite mass and collision is almost elastic
       if y - radius < 5 or y + radius + 5 > maxy then
	     vy:=-vy*collision_recoil
       end if
       if x -radius < 5 or x + radius + 5> maxx then
	vx:=-vx*collision_recoil
      end if
    elsif geometry = CLIP then
      % just let it go offscreen
    end if
    if floor_gravity then
    % gravity.  In reality gravity does not stop at the floor, but
    % it's balanced by upward force from the floor
    if y - radius > 2 then
      vy := vy + (-100 / mass) * seconds
    end if
    end if
    x:=x+vx*seconds
    y:=y+vy*seconds
 
  end step
  
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
