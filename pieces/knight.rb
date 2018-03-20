require_relative 'piece'
require_relative 'stepping_piece'

class Knight < Piece
  include SteppingPieces

  def to_s
    (self.color == :white) ? " \u2658 " : " \u265e "
  end

  def move_set
    [
      [-2, -1],
      [-2, 1],
      [-1, -2],
      [-1, 2],
      [1, -2],
      [1, 2],
      [2, -1],
      [2, 1]
    ]
  end
end
