module Messages

  def exit_message
    rate = 100
    voice = "Ralph"
    goodbye = " I'm afraid. I'm afraid, Dave. Dave, my mind is going. I can feel it. I can feel it. My mind is going. There is no question about it. I can feel it. I can feel it. I can feel it. I'm a fraaaid. Good afternoon, gentlemen. I am a Hal 9000 computer. I became operational at the H.A.L. plant in Urbana, Illinois on the 12th of January 1992. My instructor was Mr. Langley, and he taught me to sing a song. If you'd like to hear it I can sing it for you. "
    `say -r #{rate} -v #{voice} #{goodbye}`
  end

  def song
     pid = fork{ exec 'afplay', "../Rick Astley - Never Gonna Give You Up.mp3" }
  end

  def quit_commands(command)
    %w(q Q quit Quit QUIT).include?(command)
  end

  def no_commands(command)
    %w(n N no NO No).include?(command)
  end

  def yes_commands(command)
    %w(y Y yes Yes YES).include?(command)
  end

  def miss_message
    rate = 500
    voice = "Ralph"
    miss = "Look Dave, I can see you're really upset about this. I honestly think you ought to sit down calmly, take a stress pill, and think things over."
    `say -r #{rate} -v #{voice} #{miss}`
  end

  def invalid_placement
    invalid = "Just what do you think you're doing, Dave? Place the ship within the defined
    coordinates on the board"
    rate = 500
    voice = "Ralph"
    `say -r #{rate} -v #{voice} #{invalid}`
  end
end
