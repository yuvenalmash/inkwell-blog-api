class Api::V1::Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(user, _opts = {})
    if user.valid_password?(sign_in_params[:password])
      render json: { token: generate_token(user), user: user }
    else
      render json: { errors: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def respond_to_on_destroy
    head :ok
  end

  def sign_in_params
    params.require(:session).permit(user: %i[email password])[:user]
  end

  def generate_token(user)
    expiration_time = 1.day.from_now.to_i
    payload = { user_id: user.id, expiration_time: expiration_time }
    hmac_secret = Rails.application.credentials.secret_key_base
    JWT.encode(payload, hmac_secret, 'HS256')
  end
end
