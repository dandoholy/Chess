require 'byebug'
require "Singleton"
class Piece
  attr_accessor :pos
  attr_reader :color, :board
  def initialize(color=nil, board=nil, pos=nil)
    @color = color
    @board = board
    @pos = pos
  end
  

  def to_s
    "P"
  end
  
  def empty?
  
  end
  
  def valid_moves
  end
  
  def pos=(val)
    @pos = val
  end
  
  def symbol
  end
  
  private
end

class NullPiece < Piece
  include Singleton

  def to_s
    " "
  end
end

module SlidingPieces

  def move_style
    moves = Hash.new
    diag_xy = [[-1,-1],[-1,1],[1,-1],[1,1]]
    moves[:diag] = collision(diag_xy)
    # diag_xy.each do |dx,dy|
    #   x,y = self.pos
    #   (1..7).each do |num| 
    #     pot_pos = [self.pos.first + dx, self.pos.last + dy]
    #     break unless self.board.valid_pos(pot_pos)
    #     break if self.board[pot_pos].color == self.color
    #     moves[:diag] << [x+dx*num,y+dy*num]
    #     break if (self.board[pot_pos].color != self.color && self.board[pot_pos].color != nil)
    #   end
    # end
    
    straight_xy = [[1,0],[0,1],[-1,0],[0,-1]]
    moves[:straight] = collision(straight_xy)
    # straight_xy.each do |dx,dy|
    #   x,y = self.pos
    #   (1..7).each do |num|
    #     pot_pos = [self.pos.first + dx, self.pos.last + dy]
    #     break unless self.board.valid_pos(pot_pos)
    #     break if self.board[pot_pos].color == self.color
    #     moves[:straight] << [x+dx*num,y+dy*num]
    #     break if (self.board[pot_pos].color != self.color && self.board[pot_pos].color != nil)
    #   end
    # end
    moves
  end
  
  def collision(move_set)
    result = []
    
    move_set.each do |dx,dy|
      x,y = self.pos
      (1..7).each do |num| 
        pot_pos = [self.pos.first + dx, self.pos.last + dy]
        break unless self.board.valid_pos(pot_pos)
        break if self.board[pot_pos].color == self.color
        result << [x+dx*num,y+dy*num]
        break if (self.board[pot_pos].color != self.color && self.board[pot_pos].color != nil)
      end
    end
    result
  end
  
  
end

module SteppingPieces
  def move_style
    moves = Hash.new
    
    knight_moves = [[2,1],[1,2],[-2,1],[-1,2],[2,-1],[1,-2],[-2,-1],[-1,-2]]
    moves[:knight] = self.collision(knight_moves)

    king_moves = [[1,0],[0,1],[-1,0],[0,-1],[-1,-1],[-1,1],[1,-1],[1,1]]
    moves[:king] = self.collision(king_moves)
    
    moves
  end
  
  def collision(move_set)
    result = []
    
    move_set.each do |dx, dy|
      x,y = self.pos
      pot_pos = [self.pos.first + dx, self.pos.last + dy]
      next unless self.board.valid_pos(pot_pos)
      next if self.board[pot_pos].color == self.color
      result << [x+dx,y+dy]
      next if (self.board[pot_pos].color != self.color && self.board[pot_pos].color != nil)
    end
    result
  end
  
end

class Bishop < Piece
  include SlidingPieces
  def moves
    self.move_style[:diag]
  end
  
  def to_s
    "B"
  end
end

class Rook < Piece
  include SlidingPieces
  def moves
    self.move_style[:straight]
  end
  def to_s
    "R"
  end
end

class Queen < Piece
  include SlidingPieces
  def moves
    self.move_style[:diag]+self.move_style[:straight]
  end
  def to_s
    "Q"
  end
end

class Knight < Piece
  include SteppingPieces
  def moves
    self.move_style[:knight]
  end
  def to_s
    "H"
  end
end

class King < Piece
  include SteppingPieces
  def moves
    self.move_style[:king]
  end
  def to_s
    "K"
  end
end

class Pawns < Piece
  MOVE_DIFF = {black: [[1, 0],[2,0],[1,1],[1,-1]], white: [[-1,0],[-2,0],[-1,-1],[-1,1]]}
  def moves
    # if self.pos.first == 1 && self.color == :black
    #   movey = [[1,0],[2,0]]
    # elsif self.color == :black
    #   movey = [[1,0]]
    #   x,y = self.pos
    #   movey += [[1,-1],[1,1]].select{|dx, dy| board[[x+dx, y+dy]].color == :white} 
    # elsif self.pos.first == 6 && self.color == :white
    #   movey = [[-1,0],[-2,0]]
    # else
    #   movey = [[-1,0]]
    #   x,y = self.pos
    #   movey += [[-1,-1],[-1,1]].select{|dx, dy| board[[x+dx, y+dy]].color == :black} 
    # end
    
    if self.starting? 
      pawn_moveys = MOVE_DIFF[self.color].take(2).reject{|el| collision?(el)} + MOVE_DIFF[self.color].drop(2).select{|el| capture?(el)}
      x,y = self.pos
      movey = []
      pawn_moveys.each {|dx,dy| movey << [x+dx, y+dy]}
      movey
    else
      movey = MOVE_DIFF[self.color].take(1).reject{|el| collision?(el)} + MOVE_DIFF[self.color].drop(2).select{|el| capture?(el)}
    end
    movey
    
  end
  
  def collision?(move_diff)
    x,y = self.pos
    dx,dy = move_diff
    pot_pos = [x+dx, y+dy]
    if self.board[pot_pos].color != nil
      true
    else
      false
    end
  end
  
  def capture?(move_diff)
    x,y = self.pos
    dx,dy = move_diff
    pot_pos = [x+dx, y+dy]
    if (self.board[pot_pos].color != self.color && self.board[pot_pos].color != nil)
      true
    else
      false
    end
  end
  
  def starting?
    if self.color == :black && self.pos.first == 1
      true
    elsif self.color == :white && self.pos.first == 6
      true
    else
      false
    end
  end
  
  def to_s
    "P"
  end
  
  
end
