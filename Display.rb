require_relative 'Board.rb'
require 'colorize'
require_relative 'cursor.rb'

class Display
  attr_reader :cursor, :board

  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board
  end

  def colorize_rows
    board.rows.map.with_index do |row, row_num|
      colorize_row(row, row_num)
    end
  end

  def colorize_row(row, row_num)
    row.map.with_index do |piece, col_num|
      if cursor.cursor_pos == [row_num, col_num] && cursor.selected
        piece.to_s.colorize(background: :light_magenta)
      elsif cursor.cursor_pos == [row_num, col_num]
        piece.to_s.colorize(background: :light_cyan)
      elsif (row_num+col_num).odd?
        piece.to_s.colorize(background: :light_yellow)
      else
        piece.to_s.colorize(background: :light_green)
      end
    end
  end

  def render
    system('clear')
    colorize_rows.each { |row| puts row.join('') }
  end
end
