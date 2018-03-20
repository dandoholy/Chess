require_relative 'piece'
require_relative 'stepping_piece'

class King < Piece
  include SteppingPieces

  def to_s
    (self.color == :white) ? " \u2654 " : " \u265a "
  end

  def move_set
    [
      [-1, -1],
      [-1, 0],
      [-1, 1],
      [0, -1],
      [0, 1],
      [1, -1],
      [1, 0],
      [1, 1]
    ]
  end
end
