class PostsController < ApplicationController
  before_action :find_post , only: [:show, :edit, :update, :destroy, :upvote,:downvote ]
  before_action :authenticate_user!, except: [:index,:show,:user_posts]

  def index
    @posts = Post.all.order("created_at DESC")
    render json: @posts
  end

  def user_posts
    @posts = current_user.posts.order("created_at DESC")
    render json: @posts
  end

  def show
    @comments = Comment.where(post_id: @post)
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      render json: @post

    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      render @post
    end
  end

  def destroy
    @post.destroy
  end


  def upvote
    @post.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @post.downvote_by current_user
    redirect_to :back
  end


  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
