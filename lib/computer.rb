class Computer
  attr_reader :board
  attr_accessor :ship_1, :ship_2, :shot, :shots,
                :two_unit_ship, :three_unit_ship

  def initialize
    @board = ["A1","A2","A3","A4",
              "B1","B2","B3","B4",
              "C1","C2","C3","C4",
              "D1","D2","D3","D4"]
    @ship_1 = []
    @ship_2 = []
    @shots  = []
    @shot   = nil
    @two_unit_ship = 0
    @three_unit_ship = 0
  end

  def second_coord
    {"A1"=>["A2","B1"], "A2"=>["A1","A3","B2"], "A3"=>["A2","A4","B3"],"A4"=>["B4","A3"],
     "B1"=>["B2","A1","C1"], "B2"=>["B1","B3","A2","C2"], "B3"=>["A3","B2","B4","C3"], "B4"=>["A4","B3","C4"],
     "C1"=>["B1","C2","D1"], "C2"=>["C1","C3","B2","D2"], "C3"=>["B3","C2","C4","D3"], "C4"=>["B4","C3","D4"],
     "D1"=>["C1","D2"], "D2"=>["D1","D3","C2"], "D3"=>["C3","D2","D4"], "D4"=>["C4"]}
  end

  def make_ship_one
    coord_1 = board.sample
    ship_1 << coord_1
    coord_2 = second_coord[coord_1].sample
    ship_1 << coord_2
  end

  def third_coord
    { ["A1","A2"]=>"A3", ["A1","B1"]=>"C1", ["A2","A1"]=>"A3", ["A2","A3"]=>"A4", ["A2","B2"]=>"C2", ["A3","A2"]=>"A4",
      ["A3","A4"]=>"A2", ["A3","B3"]=>"C3", ["A4","A3"]=>"A2", ["A4","B4"]=>"C4", ["A4","A3"]=>"A2", ["B1","B2"]=>"B3",
      ["B1","A1"]=>"C1", ["B1","C1"]=>"A1", ["B2","B1"]=>"B3", ["B2","B3"]=>"B4", ["B2","B3"]=>"B1", ["B2","A2"]=>"C2",
      ["B2","C2"]=>"D2", ["B2","C2"]=>"A2", ["B3","A3"]=>"C3", ["B3","B2"]=>"B1", ["B3","B2"]=>"B4", ["B3","B4"]=>"B2",
      ["B3","C3"]=>"A3", ["B3","C3"]=>"D3", ["B4","A4"]=>"C4", ["B4","B3"]=>"B2", ["B4","C4"]=>"A4", ["B4","C4"]=>"D4",
      ["C1","B1"]=>"A1", ["C1","B1"]=>"D1", ["C1","C2"]=>"C3", ["C1","D1"]=>"B1", ["C2","C1"]=>"C3", ["C2","C3"]=>"C1",
      ["C2","C3"]=>"C4", ["C2","B2"]=>"A2", ["C2","B2"]=>"D2", ["C2","D2"]=>"B2", ["C3","B3"]=>"A3", ["C3","B3"]=>"D3",
      ["C3","C2"]=>"C1", ["C3","C2"]=>"C4", ["C3","C4"]=>"C2", ["C3","D3"]=>"B3", ["C4","B4"]=>"A4", ["C4","B4"]=>"D4",
      ["C4","C3"]=>"C2", ["C4","D4"]=>"B4", ["D1","C1"]=>"B1", ["D1","D2"]=>"D3", ["D2","D1"]=>"D3", ["D2","C2"]=>"B2",
      ["D3","C3"]=>"B3", ["D3","D2"]=>"D1", ["D3","D2"]=>"D4", ["D3","D4"]=>"D2", ["D4","C4"]=>"B4"}
  end

  def make_ship_two
    coord_1 = ship_2_coord_1
    coord_2 = ship_2_coord_2(ship_2[0])
    coord_3 = third_coord[ship_2]
    ship_2 << coord_1
    ship_2 << coord_2
    ship_2 << coord_3
    @ship_2 = ship_2.flatten
  end

  def ship_2_coord_1
    coord_1 = board.sample
    ship_2_coord_1 if ship_1.include?(coord_1)
    coord_1
  end

  def ship_2_coord_2(coord_1)
    coord_2 = second_coord[coord_1].sample
    ship_2_coord_2(coord_1) if ship_1.any? {|x| coord_2.include?(x)}
    coord_2
  end

  def third_coord(coords)
    coord_3 = third[coords]
    third_coord(coords) if
  end

  def two_unit_sunk?
    return true if two_unit_ship == 2
  end

  def three_unit_sunk?
    return true if three_unit_ship == 3
  end

  def firing_solution
    @shot = board.sample
    if @shots.include?(@shot)
      firing_solution
    else
      @shots << @shot
    end
    @shot
  end
end
