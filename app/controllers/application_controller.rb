class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # 定义两个 helper 方法，可以在 view 中引用
  helper_method :current_user, :logined?

  def login_as(user)
    # 把当前用户的 id 存在 session 中，session 会被返回给浏览器
    session[:user_id] = user.id

    # 把 user 的信息赋值给 instance variable（带有 @)，这是为了方便后面引用
    @current_user = user
  end

  # 如果 current_user 方法返回 nil，则说明没有登录
  def logined?
    current_user != nil
  end

  def current_user
    @current_user
  end
end
