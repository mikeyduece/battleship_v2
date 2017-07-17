require './lib/messages'

class Player
  include Messages

  attr_reader :board
  attr_accessor :ship_1, :ship_2, :shot, :shots, :two_unit_ship,
                :three_unit_ship

  def initialize
    @board = ["A1","A2","A3","A4",
              "B1","B2","B3","B4",
              "C1","C2","C3","C4",
              "D1","D2","D3","D4"]
    @ship_1 = []
    @ship_2 = []
    @shots  = []
    @shot   = ""
    @two_unit_ship = 0
    @three_unit_ship = 0
  end

  def second_coord
    {"A1"=>["A2","B1"], "A2"=>["A1","A3","B2"], "A3"=>["A2","A4","B3"], "A4"=>["B4","A3"],
     "B1"=>["B2","A1","C1"], "B2"=>["B1","B3","A2","C2"], "B3"=>["A3","B2","B4","C3"], "B4"=>["A4","B3","C4"],
     "C1"=>["B1","C2","D1"], "C2"=>["C1","C3","B2","D2"], "C3"=>["B3","C2","C4","D3"], "C4"=>["B4","C3","D4"],
     "D1"=>["C1","D2"], "D2"=>["D1","D3","C2"], "D3"=>["C3","D2","D4"], "D4"=>["C4","D3"]}
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

  def ship_1_coord_1_validation(input)
    if !board.include?(input)
      return false
    else
      ship_1 << input
    end
  end

  def ship_1_coord_2_validation(input)
    if !board.include?(input) || ship_1[0]==input || !second_coord[ship_1[0]].include?(input)
      return false
    else
      ship_1 << input
    end
  end

  def ship_2_coord_1_validation(input)
    if !board.include?(input) || ship_1.include?(input)
      return false
    else
      ship_2 << input
    end
  end

  def ship_2_coord_2_validation(input)
    if !board.include?(input) || ship_1.include?(input) || !second_coord[ship_2[0]].include?(input)
      return false
    else
      ship_2 << input
    end
  end

  def third_coord_validation(input)
    if !board.include?(input) || ship_1.include?(input) || !third_coord[ship_2[0]].any? {|x|x.include?(input)}
      return false
    else
      ship_2 << input
    end
  end

  def two_unit_sunk?
    return true if two_unit_ship == 2
  end

  def three_unit_sunk?
    return true if three_unit_ship == 3
  end

  def firing_solution(input)
    if !board.include?(input) || @shots.include?(input)
      return false
    else
      @shots << input
    end
  end

end
