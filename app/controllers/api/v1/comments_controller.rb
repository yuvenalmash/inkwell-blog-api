class Api::V1::CommentsController < ApplicationController
  before_action :set_user, only: %i[index create update destroy]
  before_action :set_post, only: %i[index create update destroy]
  before_action :set_comment, only: %i[update destroy]

  def index
    @comments = @post.comments
    render json: @comments, include: { user: { only: %i[username avatar] } }
  end

  def create
    comment = @post.comments.new(comment_params)
    comment.user = @user
    if comment.save
      render json: comment, status: :created
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment, status: :reset_content
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    render json: @comment, status: :no_content
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = @user.posts.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
