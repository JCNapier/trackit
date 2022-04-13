class UsersController < ApplicationController 
  def new 
   
  end

  def create 
    user = User.new(user_params)
  
    if user.save 
      redirect_to user_path(user)
      flash[:success] = "Welcome #{user.user_name}!"
    else  
      redirect_to new_user_path
      flash[:error] = user.errors.full_messages.join(" , ")
    end 
  end

  private 
  def user_params 
    params.permit(:user_name, :email, :password, :password_confirmation)
  end
end