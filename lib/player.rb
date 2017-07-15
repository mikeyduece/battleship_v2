class Player
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
end
