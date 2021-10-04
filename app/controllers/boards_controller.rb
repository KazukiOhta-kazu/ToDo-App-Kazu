class BoardsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def index
    @boards = Board.all
  end

  def show
  end

  def new
    @board = current_user.boards.build
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to board_path(@board)
    else
      render :new
    end
  end

  def edit
    @board = current_user.boards.find(params[:id])
  end

  def update
    @board = current_user.boards.find(params[:id])
    if @board.update(board_params)
      redirect_to board_path(@board)
    else
      render :edit
    end
  end

  private

  def board_params
    params.require(:board).permit(:title, :content)
  end
end
