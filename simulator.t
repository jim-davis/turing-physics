class Simulator
  import Configuration,PhysOb,vector,vector_invert
  export initialize,addObj,run,step
  var objs: array 1..10 of pointer to PhysOb
  var objCounter: int :=0
  var sim_time:real:=0
  var frame_counter: int:=0
  var config: pointer to Configuration

  proc initialize(config_: pointer to Configuration)
    config := config_
  end initialize

  proc addObj(b: pointer to PhysOb)
      objCounter:=objCounter + 1
      objs(objCounter):=b
  end addObj
  
  proc gravity()
    for i:1..objCounter
      for j:i+1..objCounter
	var f:vector := objs(i) -> gravity_force(objs(j))
	objs(i) -> force_add(f)
	objs(j) -> force_add(vector_invert(f))
      end for
    end for
  end gravity
  
  proc draw_world()
    for i:1..objCounter
      objs(i) -> draw
    end for
  end draw_world
  
  function any_motion: boolean
    for i:1..objCounter
      if objs(i) -> isMoving() then
    result true
      end if
    end for
    result false
  end any_motion
  
  proc show_stats()
    drawfillbox(10,5,300,25,gray)
    var fps:string:=""
    if sim_time > 0 then
      fps :=  intstr(floor(frame_counter / sim_time)) + " fps"
    else
      fps:=""
    end if
    Draw.Text(realstr(sim_time,6) + " secs " + fps, 10, 10, config -> font, black)
    frame_counter := frame_counter + 1
  end show_stats

  proc step(seconds: real)
    for i:1..objCounter
      objs(i) -> force_reset()
    end for
    drawfill(1,1,white,black)
    if config -> hasGravity ()then
      gravity()
    end if
    
    for i:1..objCounter
      objs(i) -> step(seconds)
    end for
    draw_world()
  end step

  proc run(duration: real)
    var now,last_now: int :=0
    clock(now)
    last_now := now
    loop
      clock(now)
      var step_duration:real := (now - last_now) /1000
      last_now := now
      step(step_duration)
      show_stats()
      delay(10)
      sim_time := sim_time + step_duration

      exit when sim_time >= duration 
    end loop
  end run

end Simulator

