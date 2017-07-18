module Messages

  def exit_message
    rate = 150
    goodbye = " I'm afraid. I'm afraid, Dave. Dave, my mind is going. I can feel it. I can feel it. My mind is going. There is no question about it. I can feel it. I can feel it. I can feel it. I'm a fraaaid. Good afternoon, gentlemen. I am a Hal 9000 computer. I became operational at the H.A.L. plant in Urbana, Illinois on the 12th of January 1992. My instructor was Mr. Langley, and he taught me to sing a song. If you'd like to hear it I can sing it for you. "
    `say -r #{rate} #{goodbye}`
  end

  def song
     pid = fork{ exec 'afplay', "../Rick Astley - Never Gonna Give You Up.mp3" }
  end

  def instructions
    "Enter coordinates for your ship placement in alphanumeric format ie A1 or C3.
    Ship coordinates must be consecutive and may not be placed diagonally. Once your ships have been placed,
    you will begin taking turns with the computer, firing on ships until the enemy's fleet is completely sunk."

  end

  def quit_commands(command)
    %w(q Q quit Quit QUIT).include?(command)
  end

  def yes_commands(command)
    %w(y Y yes Yes YES).include?(command)
  end

  def miss_message
    rate = 180
    `say -r #{rate} " Look Dave, I can see you're really upset about this. I honestly think you ought to sit down calmly, take a stress pill, and think things over. "`
  end

  def invalid_placement
    invalid = "Just what do you think you're doing, Dave? Place the ship within the defined coordinates on the board"
    rate = 300
    voice = "Ralph"
    `say -r 180 "Just what do you think you're doing, Dave? Place the ship within the defined coordinates on the board"`
  end
end
