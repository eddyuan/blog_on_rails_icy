class PostsController < ApplicationController
  # This is defined in ApplicationController
  before_action :authenticated_user!, except: %i[index show]
  before_action :find_post, only: %i[edit update show destroy]
  before_action :authorized_user!, only: %i[edit update destroy]
  # For showing the page
  def new
    @post = Post.new
  end

  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
    @comments = @post.comments.order(created_at: :desc)
    @comment = Comment.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to post_path @post
    else
      render :new
    end
  end

  # For writing the database

  def update
    if @post.update(post_params)
      flash[:success] = "Post updated!"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = "Post deleted!"
      redirect_to posts_path
    else
      flash[:danger] = "Can't delete"
    end
  end

  # Global fn to find the post

  private

  def find_post
    @post = Post.find params[:id]
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def authorized_user!
    unless can?(:crud, @post)
      flash[:danger] = "You don;t have permission"
      redirect_to root_path
    end
  end
end
