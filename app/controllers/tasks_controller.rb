class TasksController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def new
    board = Board.find(params[:board_id])
    @task = board.tasks.build
  end

  def create
    board = Board.find(params[:board_id])
    @task = board.tasks.build(task_params)
    @task.user_id = current_user.id
    if @task.save
      redirect_to board_task_path(board, @task)
    else
      render :new
    end
  end

  def show
    board = Board.find(params[:board_id])
    @task = board.tasks.find(params[:id])
    @comments = @task.comments
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to board_task_path(@task.board, @task)
    else
      render :edit
    end
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy!
    redirect_to board_path(task.board)
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :deadline, :eyecatch)
  end
end
