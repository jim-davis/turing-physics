class Sun
  inherit PhysOb
  
  body proc draw
    % The Sun does  not move, so we do not want to turn it grey when it is still
    drawfilloval(floor(x),floor(y),radius,radius,yellow)
  end draw
  
  body proc hide
    %drawfilloval(floor(x),floor(y),radius,radius,white)
  end hide
end Sun
