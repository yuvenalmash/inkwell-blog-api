class ApplicationController < ActionController::API
  private

  def authenticate_user!
    token = request.headers['Authorization']&.split(' ')&.last
    hmac_secret = Rails.application.credentials.secret_key_base
    payload = JWT.decode(token, hmac_secret, true, { algorithm: 'HS256' })[0]

    render json: { errors: 'Invalid token' }, status: :unauthorized if payload['user_id'] != params[:id].to_i

    render json: { errors: 'Token expired' }, status: :unauthorized if Time.at(payload['expiration_time']) < Time.now

    @current_user = User.find(payload['user_id'])
  rescue JWT::DecodeError => e
    render json: { errors: e.message, message: 'Invalid token' }, status: :unauthorized
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message, message: 'User not found' }, status: :not_found
  end
end
