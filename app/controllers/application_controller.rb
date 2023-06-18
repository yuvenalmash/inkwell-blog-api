class ApplicationController < ActionController::API
  def authenticate_user!
    token = request.headers['Authorization']&.split(' ')&.last
    return render json: { error: 'Unauthorized access' }, status: :unauthorized unless token

    begin
      decoded_token = JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: 'HS256')
      puts 'decoded_token: ', decoded_token
      return render json: { error: 'Unauthorized access' }, status: :unauthorized if decoded_token[0]['exp'] < Time.now.to_i
    rescue JWT::DecodeError
      return render json: { error: 'Unauthorized access' }, status: :unauthorized
    end

    user = User.find(decoded_token[0]['id'])
    return render json: { error: 'Unauthorized access' }, status: :unauthorized unless user.id == params[:id].to_i

    @current_user = user
  end

  attr_reader :current_user

  def bad_request
    render json: { errors: 'Invalid request parameters' }, status: :bad_request
  end

  def not_found
    render json: { errors: 'Resource not found' }, status: :not_found
  end

  def unprocessable_entity
    render json: { errors: 'Unprocessable entity' }, status: :unprocessable_entity
  end

  def internal_server_error
    render json: { errors: 'Internal server error' }, status: :internal_server_error
  end

  def forbidden
    render json: { errors: 'Forbidden' }, status: :forbidden
  end

  def unauthorized
    render json: { errors: 'Unauthorized access' }, status: :unauthorized
  end
end
