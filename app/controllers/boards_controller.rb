class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  def index
    @boards = current_user.boards.all.sort_by{ |b| [ b.year, b.name ]}
  end

  def show
    @rankings = Board.set_rankings(@board.id)
  end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.new(board_params)

    if @board.save
      redirect_to board_path(@board)
    else
      render :new
    end
  end

  def edit
  end
  
  def update
    if @board.update(board_params)
      redirect_to board_path(@board)
    else
      render :edit
    end
  end

  def destroy
    Board.remove_songs(@board.id)
    @board.destroy
    redirect_to boards_path
  end

  private
  
  def set_board
    @board = current_user.boards.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:name, :year, :description)
  end
end
