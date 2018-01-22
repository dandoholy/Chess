require_relative 'Board.rb'
require 'colorize'
require_relative 'cursor.rb'

class Display
  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board
  end
  
  def render
    @board.rows.map do |row|
      row.map do |piece|
        piece.to_s
      end
    end
  end
  
end

