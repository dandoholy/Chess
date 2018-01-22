
class Piece
  attr_accessor :pos
  attr_reader :color
  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end
  
  def moves
    
    
  end
  
  def to_s
    "P"
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
    " "
  end
end

# class Sliding Pieces
