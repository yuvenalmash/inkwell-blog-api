class Api::V1::UsersController < ApplicationController
  rescue_from ActionDispatch::Http::Parameters::ParseError, with: :bad_request
  before_action :set_user, only: %i[show update destroy]
  # before_action :authenticate_user!, except: %i[index show]

  def index
    @users = User.includes(posts: %i[comments likes]).all
    render json: @users, include: { posts: { include: %i[comments likes] } }
  end

  def show
    render json: @user, include: { posts: { include: %i[comments likes] } }
  end

  def update
    if @user.update(user_params)
      render json: @user, status: :reset_content
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      render json: @user, status: :no_content
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :bio, :avatar)
  end

  def bad_request
    render json: { errors: 'Invalid request parameters' }, status: :bad_request
  end
end
