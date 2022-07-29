class UsersController < ApplicationController
  before_action :authenticated_user!, except: %i[new create]
  before_action :find_user, only: %i[show edit update update_password]
  before_action :authorized_user!, only: %i[edit update]

  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new user_params
    # store all emails in lowercase to avoid duplicates and case-sensitive login errors:
    @user.email.downcase!
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
    if @user.update update_user_params
      flash[:success] = "User info saved"
      redirect_to root_path
    else
      render :edit
    end
  end

  def change_password
    @user = User.new
  end

  def update_password
    # @user = User.new
    @user = @current_user
    current_password = params[:current_password]
    new_password = params[:new_password]
    new_password_confirmation = params[:new_password_confirmation]

    if @user&.authenticate(current_password)
      if current_password == params[:new_password]
        @user.errors.add(:new_password, "Please use a different")
      end

      if params[:new_password] != params[:new_password_confirmation]
        @user.errors.add(:new_password, "Not matched")
      end
    else
      @user.errors.add(:current_password, "Incorrect")
    end

    if (!@user.errors.any?) && @user.update(password: new_password)
      # @user.password = new_password
      # @user.password_confirmation = new_password_confirmation
      # if @user.save
      #   flash[:success] = "Password updated"
      #   redirect_to root_path
      # else
      #   render :change_password
      # end
      flash[:success] = "Password updated"
      redirect_to root_path
    else
      render :change_password
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

  def update_user_params
    params.require(:user).permit(:name, :email)
  end

  def update_password_params
    params.require(:user).permit(:password)
  end

  def find_user
    @user = @current_user
  end

  def authorized_user!
    unless can?(:crud, @user)
      flash[:danger] = "You do not have permission"
      redirect_to root_path
    end
  end
end
