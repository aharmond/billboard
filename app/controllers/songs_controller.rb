class SongsController < ApplicationController
  before_action :set_artist, except: [:song_list, :add_song_billboard, :update]
  before_action :set_board, only: [:song_list, :add_song_billboard]
  before_action :set_song, only: [:show, :edit, :update, :destroy, :add_song_billboard]

  def index
    @songs = @artist.songs
  end

  def new
    @song = @artist.songs.new
    render partial: "form"
  end

  def create
    @song = @artist.songs.new(song_params)

    if @song.save
      redirect_to artist_path(@artist)
    else
      render :new
    end
  end

  def edit
    render partial: "form"
  end

  def update
    if @song.update(song_params)
      redirect_to artist_songs_path(@song.artist_id)
    else
      render :edit
    end
  end

  def destroy
    @song.destroy
    redirect_to artist_songs_path(@artist)
  end

  def song_list
    @songs = Song.all.sort_by { |s| [s.album, s.year]}
  end

  def add_song_billboard
  end

  private

  def set_artist
    @artist = Artist.find(params[:artist_id])
  end

  def set_board
    @board = Board.find(params[:board_id])
  end

  def set_song
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:name, :album, :year, :billboard_rank, :board_id)
  end
end
