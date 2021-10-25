class TasksController < ApplicationController
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
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :deadline)
  end
end
