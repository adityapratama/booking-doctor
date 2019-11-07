class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?
  helper_method :autorized
  helper_method :admin_authorized

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def authorized
    redirect_to login_path, notice: 'You should login first for booking doctor!' if !logged_in? 
  end

  def admin_authorized
    if !logged_in?
      return redirect_to login_path, notice: 'You should login first!'
    end

    if !@current_user&.admin?
      return redirect_to root_path, notice: 'Only admin can access admin page'
    end
  end
end
