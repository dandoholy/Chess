require_relative 'board'
require_relative 'display'
require_relative 'human_player'

class Game
  attr_reader :board, :display, :white, :black, :current_player

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @white = HumanPlayer.new(:white, @display)
    @black = HumanPlayer.new(:black, @display)
    @current_player = @white
  end

  def play
   until self.board.checkmate?(current_player.color)
     begin
       start_pos, end_pos = self.current_player.make_move
       self.board.move_piece(self.current_player.color, start_pos, end_pos)
       self.switch_players!
       check_for_check
     rescue StandardError => e
       self.display.messages.push(e.message)
       retry
     end
     self.display.clear_messages
   end
   display.render
   puts "#{current_player.color.capitalize} has been checkmated and lost!"
   nil
 end

  def switch_players!
    @current_player = (@current_player == @white) ? @black : @white
  end

  def check_for_check
    if self.board.in_check?(self.current_player.color)
      self.display.messages.push("#{self.current_player.color.capitalize} is in check!")
    end
  end
end

if $PROGRAM_NAME == __FILE__
  Game.new.play
end
