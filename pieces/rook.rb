require_relative 'piece'
require_relative 'sliding_piece'

class Rook < Piece
  include SlidingPieces

  def to_s
    (self.color == :white) ? " \u2656 " : " \u265c "
  end

  def move_set
    self.horizontal_moves
  end
end
