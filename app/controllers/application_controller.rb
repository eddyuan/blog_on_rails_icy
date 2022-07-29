class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.find_by_id session[:user_id]
  end

  helper_method :current_user

  def user_signed_in?
    current_user.present?
  end

  helper_method :user_signed_in?

  def user_is_admin?
    current_user.is_admin?
  end

  helper_method :user_is_admin?

  def authenticated_user!
    unless user_signed_in?
      flash[:danger] = "Please sign in"
      redirect_to signup_path
    end
  end

  def admin_user!
    unless user_is_admin?
      flash[:danger] = "Please sign in"
      redirect_to signup_path
    end
  end
end
