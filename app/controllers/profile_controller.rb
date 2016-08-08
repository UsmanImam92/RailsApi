class ProfileController < ApplicationController


  def index
    @posts = current_user.posts.order("created_at DESC")
    render json: @posts
  end




end
