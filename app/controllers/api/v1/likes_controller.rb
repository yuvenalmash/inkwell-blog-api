class Api::V1::LikesController < ApplicationController
  before_action :set_user, only: %i[index create destroy]
  before_action :set_post, only: %i[index create destroy]
  before_action :set_comment, only: %i[index create destroy]
  before_action :set_likeable, only: %i[index create destroy]
  before_action :set_like, only: %i[destroy]

  def index
    @likes = @likeable.likes.includes(:user).all
    render json: @likes, include: { user: { only: %i[username avatar] } }
  end

  def create
    like = @likeable.likes.new(user: @user)
    if like.save
      render json: like, status: :created
    else
      render json: { errors: like.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @user == @like.user
      @like.destroy
      render json: @like, status: :no_content
    else
      render json: { errors: 'You are not authorized to perform this action' }, status: :unauthorized
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:comment_id]) if params[:comment_id]
  end

  def set_like
    @like = @likeable.likes.find(params[:id])
  end

  def set_likeable
    if @comment
      @likeable = @comment
    elsif @post
      @likeable = @post
    end
  end
end
