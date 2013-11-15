module SessionsHelper

  def sign_in(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def current_user
    @current_user ||= sign_in_from_session || sign_in_from_cookies unless defined?(@current_user)
    @current_user
  end

  def sign_in_from_session
    if session[:user_id].present?
      begin
        User.find session[:user_id]
      rescue
        session[:user_id] = nil
      end
    end
  end

  def sign_in_from_cookies
    if cookies[:remember_token].present?
      if user = User.find_by_remember_token(cookies[:remember_token])
        session[:user_id] = user.id
        user
      else
        forget_me
        nil
      end
    end
  end

  def forget_me
    cookies.delete(:remember_token)
  end

  def signed_in?
    !!current_user
  end

  def sign_out
    session.delete(:user_id)
    @current_user = nil
    forget_me
  end

  def remember_me
    cookies[:remember_token] = {
      :value   => current_user.remember_token,
      :expires => 2.weeks.from_now
    }
  end

  def signed_in_user
    redirect_to signin_path, notice: "请先登录!" unless signed_in?
  end
end
