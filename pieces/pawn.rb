require_relative 'piece'
require_relative 'null'

class Pawn < Piece
  def to_s
    (self.color == :white) ? " \u2659 " : " \u265f "
  end

  def starting_pos?
    self.pos[0] == ((self.color == :white) ? 6 : 1)
  end

  def moves
    forward_moves + capture_moves
  end

  def forward_move
    (color == :white) ? -1 : 1
  end

  def forward_moves
    moves = []
    x, y = self.pos
    one_step_pos = [x + self.forward_move, y]
    moves << one_step_pos if (self.board.valid_pos?(one_step_pos) && self.board.pos_empty?(one_step_pos))
    two_step_pos = [x + 2*self.forward_move, y]
    moves << two_step_pos if (self.starting_pos? && self.board.pos_empty?(two_step_pos))
    moves
  end

  def capture_moves
    moves = []
    x, y = self.pos

    left_attack_pos = [x+self.forward_move, y-1]
    if (self.board.valid_pos?(left_attack_pos) &&
      self.board[left_attack_pos].color != self.color &&
      !self.board[left_attack_pos].null_piece?)
      moves << left_attack_pos
    end

    right_attack_pos = [x+self.forward_move, y+1]
    if (self.board.valid_pos?(right_attack_pos) &&
      self.board[right_attack_pos].color != self.color &&
      !self.board[right_attack_pos].null_piece?)
      moves << right_attack_pos
    end
    moves
  end




end
