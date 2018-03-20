require_relative 'piece'
require_relative 'sliding_piece'

class Queen < Piece
  include SlidingPieces

  def to_s
    (self.color == :white) ? " \u2655 " : " \u265b "
  end

  def move_set
    self.diagonal_moves.concat(self.horizontal_moves)
  end
end
