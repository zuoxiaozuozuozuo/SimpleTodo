class TodosController < ApplicationController
  before_action :authenticate!
  before_action :load_todo, only: [:edit, :update, :destroy]


  def index
    build_todo
    load_todos
  end

  def create
    todo = Todo.new(todo_params)
    todo.user_id = @current_user.id
    respond_to do |format|
      if todo.save
        format.html { redirect_to todos_path, notice: "创建成功" }
      else
        format.html { render :index }
      end
    end
  end

  def update
    load_todo
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to todos_path, notice: "更新成功" }
      else
        format.html { render :edit }
      end
    end
  end

  def edit
  end

  def destroy
    load_todo
    @todo.destroy
    respond_to do |format|
      format.html { redirect_to todos_url, notice: '删除成功' }
    end
  end


  private

  def load_todo
    @todo ||= todo_scope.find(params[:id])
  end

  def load_todos
    @todos ||= current_user.todos.ordered.group_by{ |t| t.created_at.to_date }
  end

  def build_todo
    @todo ||= todo_scope.new
    @todo.attributes = todo_params.merge(user_id: current_user.id)
  end
  def todo_scope
    Todo
  end

  def authenticate!
    # 先通过 session 中的 user_id 来查找用户，同时赋值给实例变量
    @current_user = User.find_by(id: session[:user_id])

    # 如果没找到用户，那么就重定向到登录页面
    if @current_user.blank?
      redirect_to login_path and return
    end
  end

  def todo_params
    todo_params = params[:todo]
    todo_params ? todo_params.permit(:title, :remark, :is_finished) : {}
  end

end
