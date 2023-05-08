class Api::V1::PostsController < ApplicationController
  rescue_from ActionDispatch::Http::Parameters::ParseError, with: :bad_request
  before_action :set_post, only: %i[show update destroy]

  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @posts = @user.posts
    else
      @posts = Post.all
    end
    render json: @posts
  end

  def show
    render json: @post,
           include: {
             user: { only: %i[username avatar] },
             comments: { include: { user: { only: %i[username avatar] } } },
             likes: { include: { user: { only: %i[username avatar] } } }
           }
  end

  def create
    post = Post.new(post_params)
    if post.save
      render json: post, status: :created
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: @post, status: :reset_content
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    render json: @post, status: :no_content
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:user_id, :title, :content, :slug)
  end

  def bad_request
    render json: { errors: 'Invalid request parameters' }, status: :bad_request
  end
end
