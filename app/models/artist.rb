class Artist < ApplicationRecord
  has_many :songs, dependent: :destroy

  def self.set_albums(id)
    @artist = Artist.find(id)
    @artist.songs.uniq { |s| s.album }.sort_by { |song| [song.year, song.album] }
  end

  def self.set_tracklist(id)
    @artist = Artist.find(id)
    @artist.songs.sort_by { |song| [song.year, song.track_number] }
  end
end
