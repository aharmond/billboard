class SongsController < ApplicationController
  before_action :set_artist, except: [:song_list, :add_song_billboard, :update, :remove_from_billboard]
  before_action :set_board, only: [:song_list, :add_song_billboard, :remove_from_billboard]
  before_action :set_song, only: [:show, :edit, :update, :destroy, :add_song_billboard, :remove_from_billboard]
  before_action :authenticate_user!, only: [:song_list, :add_song_billboard, :remove_from_billboard]

  def index
    @songs = @artist.songs
    @albums = Artist.set_albums(@artist.id)
    @tracklist = Artist.set_tracklist(@artist.id)
  end

  def new
    @song = @artist.songs.new
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
  end

  def update
    current_uri = request.env['PATH_INFO']
    if current_uri.include?('artists')
      if @song.update(song_params)
        redirect_to artist_songs_path(@song.artist_id)
      else
        render :edit
      end
    elsif current_uri.include?('boards')
      if @song.update(song_params)
        set_board
        redirect_to board_path(@board)
      else
        render :add_song_billboard
      end
    end
  end

  def destroy
    Song.remove_boards(@song.id)
    @song.destroy
    redirect_to artist_songs_path(@artist)
  end

  def song_list
    @songs = Song.find_songs_not_on_billboard(@board)
      
    @songs.sort_by { |s| [s.album, s.year]}
  end

  def add_song_billboard
  end

  def remove_from_billboard
    @song.update(board_id: nil)
    redirect_to board_path(@board)
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
    params.require(:song).permit(:name, :album, :year, :billboard_rank, :board_ids, :track_number)
  end
end
