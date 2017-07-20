module Messages

  def exit_message
    rate = 150
    goodbye = " I'm afraid. I'm afraid, Dave. Dave, my mind is going. I can feel it. I can feel it. My mind is going. There is no question about it. I can feel it. I can feel it. I can feel it. I'm a fraaaid. Good afternoon, gentlemen. I am a Hal 9000 computer. I became operational at the H.A.L. plant in Urbana, Illinois on the 12th of January 1992. My instructor was Mr. Langley, and he taught me to sing a song. If you'd like to hear it I can sing it for you. "
    `say -r #{rate} #{goodbye}`
  end

  def start_game
    puts "    I have laid out my ships on the grid.
    You now need to layout your two ships.
    The first is two units long and the
    second is three units long.
    The grid has A1 at the top left and D4 at the bottom right.".white
  end

  def song
    pid = fork{ exec 'afplay', "./soundfile.mp3"}
    sleep 20
    puts `killall afplay`
  end

  def instructions
    puts "    Enter coordinates for your ship placement in alphanumeric format ie A1 or C3.
    Ship coordinates must be consecutive and may not be placed diagonally. Once your ships have been placed,
    you will begin taking turns with the computer, firing on ships until the enemy's fleet is completely sunk.\n\n\n".magenta
  end

  def quit_commands(command)
    %w(q Q quit Quit QUIT).include?(command)
  end

  def yes_commands(command)
    %w(y Y yes Yes YES).include?(command)
  end

  def invalid_placement
    rate = 250
    voice = "Ralph"
    `say -r 180 "Just what do you think you're doing, Dave? Place the ship within the defined coordinates on the board"`
  end

  def game_over
    if computer.two_unit_sunk? && computer.three_unit_sunk?
      puts "You took #{@shot_count} shots."
      exit_message
      puts "(Y)es or (N)o?"
      input = gets.chomp
      if yes_commands(input)
        song
      else
        p "Goodbye!"
        exit
      end
    elsif player.two_unit_sunk? && player.three_unit_sunk?
      puts "You took #{@shot_count} shots."
      you_lose
      exit
    end
  end

  def emoji
    {"M" => "\xF0\x9F\x92\xA9",
     "H" => "\xF0\x9F\x8E\xAF"}
  end

  def you_lose
        banner = "
                  ┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼
                  ███▀▀▀██┼███▀▀▀███┼███▀█▄█▀███┼██▀▀▀
                  ██┼┼┼┼██┼██┼┼┼┼┼██┼██┼┼┼█┼┼┼██┼██┼┼┼
                  ██┼┼┼▄▄▄┼██▄▄▄▄▄██┼██┼┼┼▀┼┼┼██┼██▀▀▀
                  ██┼┼┼┼██┼██┼┼┼┼┼██┼██┼┼┼┼┼┼┼██┼██┼┼┼
                  ███▄▄▄██┼██┼┼┼┼┼██┼██┼┼┼┼┼┼┼██┼██▄▄▄
                  ┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼
                  ███▀▀▀███┼▀███┼┼██▀┼██▀▀▀┼██▀▀▀▀██▄┼
                  ██┼┼┼┼┼██┼┼┼██┼┼██┼┼██┼┼┼┼██┼┼┼┼┼██┼
                  ██┼┼┼┼┼██┼┼┼██┼┼██┼┼██▀▀▀┼██▄▄▄▄▄▀▀┼
                  ██┼┼┼┼┼██┼┼┼██┼┼█▀┼┼██┼┼┼┼██┼┼┼┼┼██┼
                  ███▄▄▄███┼┼┼─▀█▀┼┼─┼██▄▄▄┼██┼┼┼┼┼██▄
                  ┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼
                  ┼┼┼┼┼┼┼┼██┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼██┼┼┼┼┼┼┼┼┼
                  ┼┼┼┼┼┼████▄┼┼┼▄▄▄▄▄▄▄┼┼┼▄████┼┼┼┼┼┼┼
                  ┼┼┼┼┼┼┼┼┼▀▀█▄█████████▄█▀▀┼┼┼┼┼┼┼┼┼┼
                  ┼┼┼┼┼┼┼┼┼┼┼█████████████┼┼┼┼┼┼┼┼┼┼┼┼
                  ┼┼┼┼┼┼┼┼┼┼┼██▀▀▀███▀▀▀██┼┼┼┼┼┼┼┼┼┼┼┼
                  ┼┼┼┼┼┼┼┼┼┼┼██┼┼┼███┼┼┼██┼┼┼┼┼┼┼┼┼┼┼┼
                  ┼┼┼┼┼┼┼┼┼┼┼█████▀▄▀█████┼┼┼┼┼┼┼┼┼┼┼┼
                  ┼┼┼┼┼┼┼┼┼┼┼┼███████████┼┼┼┼┼┼┼┼┼┼┼┼┼
                  ┼┼┼┼┼┼┼┼▄▄▄██┼┼█▀█▀█┼┼██▄▄▄┼┼┼┼┼┼┼┼┼
                  ┼┼┼┼┼┼┼┼▀▀██┼┼┼┼┼┼┼┼┼┼┼██▀▀┼┼┼┼┼┼┼┼┼
                  ┼┼┼┼┼┼┼┼┼┼▀▀┼┼┼┼┼┼┼┼┼┼┼▀▀┼┼┼┼┼┼┼┼┼┼┼
                  ┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼"
                  puts banner
  end

  def ascii_ship
    "

                                                                                                                                    '  _.'
                                                                                                                                _.--'' |
                                                                                                                          _.--''       |
                                                                                                                    _.--''      _..,.  |
                                                                                                              _.--''            .==; '.|
                                                                                                        _.--''                     :   |'.
                                                                                                  _.--''                            ;  |  '.
                                                                                            _.--''                                  :  |    '.
                                                                                      _.--''                                         ; |      '.
                                                                                _.--''                         _.                    : |        '.
                                                                          _.--''                         _.--^'  :                   q I     --mmm--
                                                                    _.--''                              ;      _,.;_                 |_I____._''\\''___/___._.__
                                                              _.--''                                    :_.--^''''   :_]                |______|     ==' ' '''_|'''
                                                      |__.--''                                           ;         ;|                |;I H| |_______'''(|)|''
                                                  ''.   | :                                                :     _   :|                |:I_H|_|______['' '._|    _.---.______
                                                  I   | ;             ,    \\                    \\         ;__ [_]___;                |||____________| '''_|    \\|   ;''         |''
                           ''______.---._    ______ I  /|:        ''\\     ;\\    \\                    \\''      ,d.-^'|| '-.b.     ___       L| I|  |'''  |   |_[_|_X__[|___:_,.-^>_.---.______             /|
    ;                          '':''|''|/    _\\--/  I_/_|;         \    :/\ __nm__                _nm   _d______||______b.__EEEE3       | I|__| m |___|__H_____|_ m__|''^|''  \\|  ;''                //|
    ;      ______.---._<^-.,_____;___|]__\\|____|_|I___|] .--_____nm____; |_dHH|_|.-           |dHH|_|,-======''==_===;===|====|______|_I|__|_W_|___|__H_____^__W__|__|____|___:___,.--._nnn__m__//_o
    :\\         '':   |/ ''''|  |   __ m ___ .d88b. H m m || |_|-|-|-|-|-|-|  H*''|  .mmmmmmmmm^^' '|m[]H'm''''''|   |_| []  [_]   /*  *  * * * * *|_|''7 | *  *   *   *   *  *  *  *  *  *     .V.    ;
    :_\\__,.,_n_m_;___|]_I|_[|__[__]W_____'Y88P'_H_W_W_||_|_|_|_|_|_|_|_|__H&[]|_____^MMMM^______|W__H%$&$__I_____ -'________.-'                | | /  |                                    ^(8)-  ;
    |<    H  * * *  * *  * *  *  * *  * * * * * * * *  *  *  *  *  *   *   *  *  *  *                                                                                       *  *  *   *  *       :
    |  _|_H_|_                                           ___________________________________________________________________________________                           [Matzec]                 ;
    '-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------''
    "

  end

  def logo

                banner = " /$$$$$$$              /$$     /$$     /$$                     /$$       /$$
| $$__  $$            | $$    | $$    | $$                    | $$      |__/
| $$  \\ $$  /$$$$$$  /$$$$$$ /$$$$$$  | $$  /$$$$$$   /$$$$$$$| $$$$$$$  /$$  /$$$$$$
| $$$$$$$  |____  $$|_  $$_/|_  $$_/  | $$ /$$__  $$ /$$_____/| $$__  $$| $$ /$$__  $$
| $$__  $$  /$$$$$$$  | $$    | $$    | $$| $$$$$$$$|  $$$$$$ | $$  \\ $$| $$| $$  \\ $$
| $$  \\ $$ /$$__  $$  | $$ /$$| $$ /$$| $$| $$_____/ \\____  $$| $$  | $$| $$| $$  | $$
| $$$$$$$/|  $$$$$$$  |  $$$$/|  $$$$/| $$|  $$$$$$$ /$$$$$$$/| $$  | $$| $$| $$$$$$$/
|_______/  \\_______/   \\___/   \\___/  |__/ \\_______/|_______/ |__/  |__/|__/| $$____/
                                                                           | $$
                                                                           | $$
                                                                           |__/"
     puts banner
  end

end
