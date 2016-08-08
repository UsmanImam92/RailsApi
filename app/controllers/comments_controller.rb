class CommentsController < ApplicationController
  before_action :authenticate_user!


  def index
    @posts = Post.find(params[:post_id])
    @comments = @posts.comments.order("created_at DESC")
    render json: @comments
  end



  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.create(params[:comment].permit(:content))
    @comment.user_id = current_user.id
    @comment.post_id = @post.id
    if @comment.save
      render json: @comment
    else
      render json: @post

    end
  end
end
