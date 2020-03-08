class TasksController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = Task.all.page(params[:page])
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] =  '正常に登録できました'
      redirect_to @task
    else
      flash.now[:danger] = '登録できませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = '正常に更新できました'
      redirect_to @task
    else
      flash[:danger] = '更新できませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy
    
    flash[:success] = '正常に削除できました'  
    redirect_to tasks_url
  end
  
  private
  #Strong Parameter
  def set_message
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
end
