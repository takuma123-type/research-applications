class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :create]
  def index
    @posts = Post.all
    # render json: @posts
    @post = Post.new
    # render json: @post
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def post_params
    params.require(:post).permit(:content, :title)
  end
end
