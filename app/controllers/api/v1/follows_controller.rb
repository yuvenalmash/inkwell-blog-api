class Api::V1::FollowsController < ApplicationController
  before_action :set_user, only: %i[index create destroy]

  def index
    @followers = Follow.where(followed_id: @user.id)
    @following = Follow.where(follower_id: @user.id)
    render json: { followers: @followers, following: @following }
  end

  def create
    follow = Follow.new(followed_id: params[:followed_id], follower_id: @user.id)
    if follow.save
      render json: follow, status: :created
    else
      render json: { errors: follow.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    follow = Follow.find(params[:id])
    if @user == follow.follower
      if follow.destroy
        render json: follow, status: :no_content
      else
        render json: { errors: follow.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: 'You are not authorized to perform this action' }, status: :unauthorized
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
