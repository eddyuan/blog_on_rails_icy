class UsersController < ApplicationController
  # before_action :authenticated_user!, except: %i[new create]
  before_action :authenticated_user!, except: %i[new create]
  before_action :find_user, only: %i[show edit update update_password]
  before_action :admin_user!, only: [:index]

  def index
    @users = User.order(id: :asc)
  end

  # Get
  def new
    @user = User.new
  end

  def show
  end

  # Post
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

  # Get
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

  # Post
  def update_password
    current_password = params[:current_password]
    new_password = params[:new_password]
    new_password_confirmation = params[:new_password_confirmation]

    unless @user&.authenticate(current_password)
      @user.errors.add(:current_password, "incorrect")
    end

    if new_password.present?
      if current_password == new_password
        @user.errors.add(:new_password, "can not be the same as current")
      end
    else
      @user.errors.add(:new_password, "can not be blank")
    end

    unless @user.errors.any?
      @user.update(
        password: new_password,
        password_confirmation: new_password_confirmation
      )
    end

    if @user.errors.any?
      render :change_password
    else
      flash[:success] = "Password updated"
      redirect_to root_path
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

  # There'is another way of using strong params, which requires @user model in the form
  # In that case, it will be params[:user][:password] ...
  # def update_password_params
  #   params.require(:user).permit(:password, :password_confirmation)
  # end

  def find_user
    # We already have current user in application_controller
    @user = @current_user
  end

  def authorized_user!
    unless can?(:crud, @user)
      flash[:danger] = "You do not have permission"
      redirect_to root_path
    end
  end
end
