class Song < ApplicationRecord
  belongs_to :artist
  has_many :boardssongs
  has_many :boards, through: :boardssongs

  def self.find_songs_not_on_billboard(board)
    songs = []
    Song.all.each do |song|
      if song.board_ids != board.id
        songs << song
      end
    end
    songs
  end

  def self.remove_boards(id)
    @song = Song.find(id)
    Boardssong.all.each do |d|
      if d.song_id == @song.id
        d.destroy
      end
    end
  end
end
