class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: { message: 'Signed up successfully' }, status: :ok
    else
      render json: { errors: ['Email or username already exists'] }, status: :unprocessable_entity
    end
  end

  def respond_to_on_destroy
    head :no_content
  end

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def user_exists?(email, username)
    User.find_by(email: email) || User.find_by(username: username)
  end
end
