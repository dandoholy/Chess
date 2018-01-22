
class Piece
  attr_accessor :pos
  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end
  
  def to_s
    :P
  end
  
  def empty?
  
  end
  
  def valid_moves
  end
  
  def pos=(val)
    @pos = val
  end
  
  def symbol
  end
  
  private
end

class NullPiece < Piece
  def initialize(color, board, pos)
    super
    
  end
  
  def to_s
    :N
  end
end

