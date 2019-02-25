class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  
  def index
    @boards = Board.all.sort_by{ |b| [ b.year, b.name ]}
  end

  def show
    @rankings = Board.set_rankings(@board.id)
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)

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
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:name, :year, :description)
  end
end
