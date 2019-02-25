class Board < ApplicationRecord
  has_many :songs

  def self.set_rankings(id)
    @board = Board.find(id)
    @board.songs.sort_by { |song| song.billboard_rank }
  end

  def self.remove_songs(id)
    @board = Board.find(id)
    @board.songs.update_all(board_id: nil)
  end
end
