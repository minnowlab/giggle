module SessionsHelper

  def sign_in(admin)
    remember_token = Admin.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    admin.update_attribute(:remember_token, Admin.encrypt(remember_token))
    self.current_admin = admin
  end

  def current_admin=(admin)
    @current_admin = admin
  end

  def current_admin
    remember_token = Admin.encrypt(cookies[:remember_token])
    @current_admin ||= Admin.find_by(remember_token: remember_token)
  end

  def signed_in?
    !current_admin.nil?
  end

  def sign_out
    self.current_admin = nil
    cookies.delete(:remember_token)
  end

  def signed_in_admin
    redirect_to signin_path, notice: "请先登录!" unless signed_in?
  end

end
