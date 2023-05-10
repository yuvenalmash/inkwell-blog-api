class Api::V1::PostsController < ApplicationController
  rescue_from ActionDispatch::Http::Parameters::ParseError, with: :bad_request
  before_action :set_post, only: %i[show update destroy]
  before_action :set_user, only: %i[index create update destroy]

  def index
    @posts = if @user
               @user.posts
             else
               Post.all
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
    post.user = @user
    if post.save
      render json: post, status: :created
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @user == @post.user
      if @post.update(post_params)
        render json: @post, status: :reset_content
      else
        render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: 'You are not authorized to perform this action' }, status: :unauthorized
    end
  end

  def destroy
    if @user == @post.user
      @post.destroy
      render json: @post, status: :no_content
    else
      render json: { errors: 'You are not authorized to perform this action' }, status: :unauthorized
    end
  end

  private

  def set_user
    return unless params[:user_id]

    @user = User.find(params[:user_id])
  end

  def set_post
    @post = Post.includes(comments: :user, likes: :user, user: {}).find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :slug)
  end

  def bad_request
    render json: { errors: 'Invalid request parameters' }, status: :bad_request
  end
end
