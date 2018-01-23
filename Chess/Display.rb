require_relative 'Board.rb'
require 'colorize'
require_relative 'cursor.rb'

class Display
  attr_reader :cursor
  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board
  end
  
  def render
    @board.rows.each_with_index do |row, i|
      
      row.each_with_index do |piece, j|
        if piece.color == :white
          str = piece.to_s.colorize(:white)
        elsif piece.color == :black
          str = piece.to_s.colorize(:black)
        else
          str = piece.to_s
        end 
        # piece.to_s if piece.color == :white
        # piece.to_s if piece.color == :black
        str = str.colorize(background: :green) if [i, j] == @cursor.cursor_pos
        print str
      end
      puts
    end
    
    
    
  end
  
end



if __FILE__ == $PROGRAM_NAME
  b = Board.new
  d = Display.new(b)
  while true
    system('clear')
    d.render
    d.cursor.get_input
  end
end