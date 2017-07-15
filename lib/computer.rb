class Computer
  attr_reader :board, :ship_1, :ship_2

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

  def make_ship_one
    coord_1 = board.sample.sample
    ship_1 << coord_1
    coord_2 = second_coord[coord_1].sample
    ship_1 << coord_2
  end

  def third_coord
    {"A1"=>[["A2","A3"],["B1","C1"]], "A2"=>["A1","A3"],
      "A3"=>["A2","A4"], "A4"=>[["A2","A3"],["B4","C4"]],
      "B1"=>[["A1","C1"],["B2","B3"]], "B2"=>[["B1","B3"],["A2","C2"]],
      "B3"=>[["B2","B4"],["A3","C3"]], "B4"=>[["B2","B3"],["A4","C4"]],
      "C1"=>[["B1","D1"],["C2","C3"]], "C2"=>[["B2","D2"],["C1","C3"]],
      "C3"=>[["B3","D3"],["C2","C4"]], "C4"=>[["B4","D4"],["C2","C3"]],
      "D1"=>[["B1","C1"],["D2","D3"]], "D2"=>["D1","D3"],
      "D3"=>["D2","D4"], "D4"=>[["B4","C4"],["D2","D3"]]}
  end

  def make_ship_two
    coord_1 = ship_2_coord_1
    coord_2 = ship_2_coord_2_and_3(coord_1)
    ship_2 << coord_1
    ship_2 << coord_2
    ship_2 = ship_2.flatten
    require "pry"; binding.pry
  end

  def ship_2_coord_1
    coord_1 = board.sample.sample
    ship_2_coord_1 if ship_1.include?(coord_1)
    coord_1
  end

  def ship_2_coord_2_and_3(coord_1)
    coord_2 = third_coord[coord_1].sample
    ship_2_coord_2_and_3(coord_1) if ship_1.any? {|coord| coord == coord_2}
    coord_2
  end
end
