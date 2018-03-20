module SteppingPieces
  def moves
    moves = []
    moves.concat(self.add_moves)
    moves
  end

  def move_set
    raise NotImplementedError
  end

  def add_moves
    moves = []

    self.move_set.each do |dx, dy|
      x, y = self.pos
      new_pos = [x + dx, y + dy]

      next unless self.board.valid_pos?(new_pos)
      
      if self.board.pos_empty?(new_pos)
        moves << new_pos
      elsif self.board[new_pos].color != color
        moves << new_pos
      end
    end

    moves
  end
end
