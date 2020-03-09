class TasksController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  
  def index
    if logged_in?
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      #@tasks = Task.all.page(params[:page])
    end
    
  end

  def show
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
      render 'toppages/index'
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
