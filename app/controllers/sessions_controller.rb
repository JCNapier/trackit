class SessionsController < ApplicationController
  def new; end

  def create 
    user = User.find_by(user_name: user_params[:user_name])

    if user.present?
      if user.authenticate(user_params[:password])
        session[:user_id] = user.id

        redirect_to user_path(user) 
        flash[:success] = "Welcome Back #{user.user_name}!"
      else 
        redirect_to new_session_path
        flash[:error] = "Email and/or Password is Invalid"
      end
    else 
      redirect_to new_session_path
      flash[:error] = "Email and/or Password is Invalid"
    end
  end

  private 
  def user_params
    params.permit(:user_name, :password)
  end
end