# app/controllers/auth_controller.rb
class AuthController < ApplicationController
  before_action :authorize_request, except: :login

  def login
    @user = User.find_by_email(params[:auth][:email])
    if @user && @user.authenticate(params[:auth][:password])
      token = jwt_encode(user_id: @user.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def logout
    # Aqui pode ter lógica de logout, como invalidação de token
    render json: { message: 'Logged out' }, status: :ok
  end

  private

  def login_params
    params.require(:auth).permit(:email, :password)
  end
end
