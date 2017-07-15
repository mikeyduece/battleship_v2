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

  def second_coord_selection
    {"A1"=>["A2","B1"}, "A2"=>["A3","B2"], "A3"=>["A4","B3"],"A4"=>["B4"],
     "B1"=>["B2","A1"}, "B2"=>["B3","B2"], "B3"=>["B4","B3"],"B4"=>["B4"],
  end
end
