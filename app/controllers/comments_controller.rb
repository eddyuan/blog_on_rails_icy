class CommentsController < ApplicationController
  before_action :authenticated_user!, except: %i[index show]
  before_action :find_post, only: %i[create destroy]
  before_action :find_comment, only: [:destroy]
  def create
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post = @post
    if @comment.save
      flash[:success] = "Comment created successfully!"
      redirect_to post_path(@post)
      # if saved successfully then redirect to the show page of the question
      # otherwise still go to this show page but using render
      # the difference between redirect and render
      # redirect is sending a get request '/questions/:id'
      # render is rendering the page
    else
      # we want to stay on this page
      @comments = @post.comments.order(created_at: :desc)
      # '/questions/show' is not the action
      # it's the page /questions/show.html.erb
      render "/posts/show", status: 303
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = "Comment Deleted!"
    redirect_to post_path(@post)
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:title, :body)
  end
end
