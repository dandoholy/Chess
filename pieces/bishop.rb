require_relative 'piece'
require_relative 'sliding_piece'

class Bishop < Piece
  include SlidingPieces

  def move_set
    diagonal_moves
  end

  def to_s
    (self.color == :white) ? " \u2657 " : " \u265d "
  end
end
