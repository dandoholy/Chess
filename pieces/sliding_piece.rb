module SlidingPieces
  HORIZONTAL_MOVES = [
    [-1, 0],
    [0, -1],
    [0, 1],
    [1, 0]
  ].freeze

  DIAGONAL_MOVES = [
    [-1, -1],
    [-1, 1],
    [1, -1],
    [1, 1]
  ].freeze

  def horizontal_moves
    HORIZONTAL_MOVES
  end

  def diagonal_moves
    DIAGONAL_MOVES
  end

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
      loop do
        x, y = x + dx, y + dy
        new_pos = [x, y]

        break unless self.board.valid_pos?(new_pos)

        if self.board[new_pos].color == color
          break
        elsif self.board.pos_empty?(new_pos)
          moves << new_pos
        elsif self.board[new_pos].color != color
          moves << new_pos
          break
        end
      end
    end

    moves
  end
end
