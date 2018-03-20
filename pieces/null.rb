require 'singleton'
require_relative 'piece'

class NullPiece < Piece
  include Singleton

  def initialize
    @color = :none
  end

  def to_s
    "   "
  end

  def moves
    []
  end
end
