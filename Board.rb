require_relative 'pieces'
require 'byebug'

class Board
  attr_reader :rows, :sentinel

  def initialize(duping = false)
    @sentinel = NullPiece.instance
    fill_board(duping)
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

  def dup
    new_board = Board.new(true)
    self.pieces.each do |piece|
      new_board[piece.pos] = piece.class.new(piece.color, new_board, piece.pos)
    end
    new_board
  end

  def move_piece(color, start_pos, end_pos)
    raise "No piece at that position!" if self.pos_empty?(start_pos)
    piece = self[start_pos]
    raise "That's not your piece!" unless piece.color == color
    raise "That piece cannot make that move!" unless piece.valid_move?(end_pos)
    raise "You cannot move into check!" if piece.moving_into_check?(end_pos)
    self.move_piece!(start_pos, end_pos)
  end

  def move_piece!(start_pos, end_pos)
    piece = self[start_pos]
    raise "That piece cannot make that move!" unless piece.valid_move?(end_pos)
    self[end_pos] = piece
    self[start_pos] = sentinel
    self[end_pos].pos = end_pos
    nil
  end

  def valid_pos?(pos)
    pos.all? { |n| n.between?(0, 7) }
  end

  def pieces
    @rows.flatten.reject(&:null_piece?)
  end

  def in_check?(color)
    self.pieces.reject{|piece| piece.color == color}.any? do |piece|
      piece.moves.include?(find_king(color).pos)
    end
  end

  def checkmate?(color)
    return false unless self.in_check?(color)
    pieces.select{|piece| piece.color == color}.all? do |piece|
      piece.valid_moves.empty?
    end
  end

  private

  def find_king(color)
    self.pieces.find { |piece| piece.is_a?(King) && piece.color == color}
  end

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

  def fill_board(duping)
    @rows = Array.new(8) { Array.new(8, sentinel) }
    return if duping
    [:white, :black].each do |color|
      fill_back_row(color)
      fill_front_row(color)
    end
  end

end
