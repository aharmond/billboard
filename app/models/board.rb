class Board < ApplicationRecord
  has_many :boardssongs
  has_many :songs, through: :boardssongs
  belongs_to :user

  def self.set_rankings(id)
    @board = Board.find(id)
    @board.songs.sort_by { |song| song.billboard_rank }
  end

  def self.remove_songs(id)
    @board = Board.find(id)
    Boardssong.all.each do |d|
      if d.board_id == @board.id
        d.destroy
      end
    end
  end
end
