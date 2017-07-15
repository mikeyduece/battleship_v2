require './lib/messages'

class Player
  include Messages

  attr_reader :board
  attr_accessor :ship_1, :ship_2

  def initialize
    @board = [["A1","A2","A3","A4"],
              ["B1","B2","B3","B4"],
              ["C1","C2","C3","C4"],
              ["D1","D2","D3","D4"]]
    @ship_1 = []
    @ship_2 = []
  end

  def second_coord
    {"A1"=>["A2","B1"], "A2"=>["A1","A3","B2"], "A3"=>["A2","A4","B3"],"A4"=>["B4"],
     "B1"=>["B2","A1","C1"], "B2"=>["B1","B3","A2","C2"], "B3"=>["A3","B2","B4","C3"], "B4"=>["A4","B3","C4"],
     "C1"=>["B1","C2","D1"], "C2"=>["C1","C3","B2","D2"], "C3"=>["B3","C2","C4","D3"], "C4"=>["B4","C3","D4"],
     "D1"=>["C1","D2"], "D2"=>["D1","D3","C2"], "D3"=>["C3","D2","D4"], "D4"=>["C4"]}
  end

  def ship_1_placement(command)
    ask_for_ship_1_coords
    get_coords
    if quit_commands(command)
      exit_message
      exit
    else
      start_commands()
    end
  end

  def third_coord
    { "A1"=>[["A2","A3"],["B1","C1"]], "A2"=>[["A1","A3"],["B2","C2"]],
      "A3"=>[["A2","A4"],["B3","C3"]], "A4"=>[["A2","A3"],["B4","C4"]],
      "B1"=>[["A1","C1"],["B2","B3"]], "B2"=>[["B1","B3"],["A2","C2"]],
      "B3"=>[["B2","B4"],["A3","C3"]], "B4"=>[["B2","B3"],["A4","C4"]],
      "C1"=>[["B1","D1"],["C2","C3"]], "C2"=>[["B2","D2"],["C1","C3"]],
      "C3"=>[["B3","D3"],["C2","C4"]], "C4"=>[["B4","D4"],["C2","C3"]],
      "D1"=>[["B1","C1"],["D2","D3"]], "D2"=>[["D1","D3"],["B2","C2"]],
      "D3"=>[["D2","D4"],["C3","B3"]], "D4"=>[["B4","C4"],["D2","D3"]]}
  end

  def get_coords
    input = gets.chomp
    messages.change_commands(input)
    messages.set_commands
  end

  def change_commands(command)
    commands = command.split
    second_entry(commands)
    long_third_command(commands,commands[1])
    @first_command = commands[0] if commands[0] != nil
    @second_command = commands[1] if commands[1] != nil
    @third_command = commands[2] if commands[2] != nil
  end

  def set_commands
    @first_command  = commands.first_command
    @second_command = commands.second_command if commands.second_command != nil
    @third_command  = commands.third_command if commands.third_command != nil
  end

end
