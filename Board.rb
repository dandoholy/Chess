require_relative 'pieces'

class Board
  attr_reader :rows, :sentinel

  def initialize()
    @sentinel = NullPiece.instance
    fill_board
  end

  def [](pos)
    row, col = pos
    self.rows[row][col]
  end

  def []=(pos,val)
    row, col = pos
    self.rows[row][col] = val
  end

  def pos_empty?(pos)
    self[pos] == sentinel
  end

  def move_piece(start_pos, end_pos)
    raise "No piece at that position!" if self.pos_empty?(start_pos)
    piece = self[start_pos]
    raise "That piece cannot make that move!" unless piece.valid_move?(end_pos)
    self[end_pos] = self[start_pos]
    self[start_pos] = sentinel
    self[end_pos].pos = end_pos
    nil
  end

  def valid_pos?(pos)
    pos.all? { |n| n.between?(0, 7) }
  end

  private

  def fill_back_row(color)
    pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    row = (color == :white) ? 7 : 0
    pieces.each_with_index do |piece, col|
      self[[row, col]] = piece.new(color, self, [row, col])
    end
  end

  def fill_front_row(color)
    row = (color == :white) ? 6 : 1
    8.times do |col|
      self[[row, col]] = Pawn.new(color, self, [row, col])
    end
  end

  def fill_board
    @rows = Array.new(8) { Array.new(8, sentinel) }
    [:white, :black].each do |color|
      fill_back_row(color)
      fill_front_row(color)
    end
  end

end
