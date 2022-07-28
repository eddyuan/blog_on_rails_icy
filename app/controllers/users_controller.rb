class UsersController < ApplicationController
  before_action :authenticated_user!, except: %i[new create]
  before_action :find_user, only: %i[edit update]
  before_action :authorized_user!, only: %i[edit update]

  def new
    @user = User.new
  end

  def show
    @user = User.find params[:id]
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Thank you for signing up!"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update params.require(:user).permit(
                      :name,
                      :email,
                      :password,
                      :password_confirmation
                    )
      redirect_to root_path
    else
      flash.alert = "try again"
      render :edit
    end
  end

  def change_password
    @user = User.new
  end

  def update_password
    if @user&.authenticate(params[:user][:current_password])
      if params[:user][:current_password] == params[:user][:password]
        @user.errors.add(:current_password, "try again")
      end

      if params[:user][:password] != params[:user][:password_confirmation]
        @user.errors.add(:password, "try again")
      end

      if (!@user.errors.any?) && (@user.update user_params)
        flash[:success] = "Password updated"
        redirect_to root_path
      else
        render :change_password
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end

  def find_user
    @user = User.find_by_id params[:id]
  end

  def authorized_user!
    redirect_to root_path, alert: "Not authorized" unless can?(:crud, @user)
  end
end
