class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:email])
    
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      render json: { message: 'Login successful', user: @user }, status: :ok
    else
      render json: { errors: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    session[:user_id] = nil  # If using sessions
    render json: { message: 'Logged out successfully' }, status: :ok
  end
end
