class Api::V1::UsersController < ApplicationController
  rescue_from ActionDispatch::Http::Parameters::ParseError, with: :bad_request
  before_action :set_user, only: [:show]

  def index
    @users = User.all
    render json: @users, include: { posts: { include: %i[comments likes] } }
  end

  def show
    render json: @user, include: { posts: { include: %i[comments likes] } }
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user, status: :reset_content
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password_digest, :bio, :avatar)
  end

  def bad_request
    render json: { errors: 'Invalid request parameters' }, status: :bad_request
  end
end
