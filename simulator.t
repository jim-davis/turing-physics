class Simulator
  import PhysOb, Sun
  export addObj,addSun,run
  var objs: array 1..10 of pointer to PhysOb
  var sun: pointer to Sun :=nil
  var objCounter: int :=0

  proc addObj(b: pointer to PhysOb)
      objCounter:=objCounter + 1
      objs(objCounter):=b
  end addObj
  
  proc addSun(s: pointer to Sun)
    sun := s
  end addSun
  
  proc solar_gravity()
  end solar_gravity
  
  proc draw_world()
    for i:1..objCounter
      objs(i) -> draw
    end for
    if not sun = nil then
      sun -> draw
    end if
  end draw_world

  proc step(seconds: real)
    for i:1..objCounter
      objs(i) -> hide
    end for
    if not sun = nil then
	solar_gravity()
    end if
    for i:1..objCounter
      objs(i) -> step(seconds)
    end for
    draw_world()
  
  end step
  
  function any_motion: boolean
    for i:1..objCounter
      if objs(i) -> isMoving() then
	result true
      end if
    end for
    result false
  end any_motion
  
  proc run(duration: int)
    var sim_time:real:=0
    var now,last_now: int :=0
    clock(now)
    last_now := now
    var step_duration: real
    var fps:string:=""
    var frame_counter: int:=0
    var font:int:=Font.New("serif:12")
    loop
      clock(now)
      step_duration := (now - last_now) /1000
      last_now := now
      step(step_duration)
      delay(20)
      sim_time := sim_time + step_duration
      
      drawfillbox(10,5,300,25,gray)
      if sim_time > 0 then
	fps :=  intstr(floor(frame_counter / sim_time)) + " fps"
      else
	fps:=""
      end if
      Draw.Text(realstr(sim_time,6) + " secs " + fps, 10, 10, font, black)
      frame_counter := frame_counter + 1
      exit when sim_time >= duration or not any_motion()
    end loop
  end run

end Simulator
