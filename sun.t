class Sun
  inherit PhysOb
  
  body proc draw
    % The Sun does  not move, so we do not want to turn it grey when it is still
    drawfilloval(floor(position.x),floor(position.y),radius,radius,yellow)
  end draw
  

end Sun
