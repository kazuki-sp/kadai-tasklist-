class TasksController < ApplicationController

  before_action :require_user_logged_in
  before_action :correct_user, only: [:show,:edit,:update,:destroy]
  
  def index
    if logged_in?
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      #@tasks = Task.all.page(params[:page])
    end
    
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'tasks/index'
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
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      flash[:danger] = 'あなたに権限はありません'
      redirect_to root_url
    end
  end
end
