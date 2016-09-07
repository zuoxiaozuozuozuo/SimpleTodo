class SessionsController < ApplicationController
  def new
  end

  def create
  # 通过用户名去数据库中查找用户
  user = User.find_by(username: params[:username])

  # 如果用户找到，同时密码匹配
  if user && user.authenticate(params[:password])
    # 如果成功，则跳转到 login_as 方法，下面会给出实现
    login_as user

    # 设置登陆成功提示信息，同时跳转到 todos 页面
    flash[:notice] = "登陆成功"
    redirect_to todos_path
  else

    # 登陆不成功，设置出错提示信息，同时渲染登录页面
    flash[:error] = "用户名或密码错误"
    render :new
  end
end

  def destroy
  end
end
