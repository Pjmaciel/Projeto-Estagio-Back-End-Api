class AuthController < ApplicationController
  skip_before_action :authorize_request, only: :login

  def login
    puts "Login Params: #{login_params.inspect}"  # Adiciona esta linha para depuração
    @user = User.find_by(email: login_params[:email])
    if @user&.authenticate(login_params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      render json: { user: @user, token: token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.require(:auth).permit(:email, :password)
  end
end
