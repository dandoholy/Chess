require 'byebug'

class Piece
  attr_accessor :pos
  attr_reader :color, :board

  def initialize(color=nil, board=nil, pos=nil)
    @color = color
    @board = board
    @pos = pos
  end

  def valid_move?(end_pos)
    self.moves.include?(end_pos)
  end

  def pos=(val)
    @pos = val
  end

  private
end
