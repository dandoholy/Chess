require_relative 'Piece.rb'

class Board
  attr_reader :rows
  def initialize()
    @rows = Array.new(8) { Array.new(8) }
    @sentinel = NullPiece.new(:nil, self, [])
    @rows.map!.with_index do |row,idx|
      row.map!.with_index do |col,idx2| 
        if idx < 2 
          Piece.new(:black, self, [idx,idx2])
        elsif idx > 5
          Piece.new(:white, self, [idx,idx2])
        else
          @sentinel
        end
      end
    end

  end
  
  def [](pos)
    row,col = pos
    self.rows[row][col]
  end
  
  def []=(pos,val)
    row,col = pos 
    self.rows[row][col] = val
  end
  
  def move_piece(start_pos,end_pos)
    self[end_pos] = self[start_pos]
    self[start_pos] = @sentinel
    self[end_pos].pos = end_pos
    #@sentinel.position << start_pos
    raise NoPieceError if self[start_pos].nil?
    #raise InvalidMoveError # if TODO check valid move
  end
  
  def valid_pos(pos)
    pos.all? {|n| -1 < n && n < 8}
  end
  
end
