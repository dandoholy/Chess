require_relative 'player'
require_relative 'display'

class HumanPlayer < Player

  def make_move
    start_pos, end_pos = nil, nil
    until start_pos && end_pos
      self.display.render
      if start_pos
        puts "It is #{self.color}'s turn to move.  Where would you like to move?"
        end_pos = self.display.cursor.get_input
      else
        puts "It is #{self.color}'s turn to move.  What piece would you like to move?"
        start_pos = self.display.cursor.get_input
      end
    end

    [start_pos, end_pos]
  end

end
