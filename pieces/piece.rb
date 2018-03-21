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

  def valid_moves
    self.moves.reject { |end_pos| self.moving_into_check?(end_pos) }
  end

  def pos=(val)
    @pos = val
  end

  def null_piece?
    self.is_a?(NullPiece)
  end

  def moving_into_check?(end_pos)
    new_board = self.board.dup
    new_board.move_piece!(self.pos, end_pos)
    new_board.in_check?(self.color)
  end
end
