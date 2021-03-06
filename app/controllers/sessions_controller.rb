class SessionsController < ApplicationController

   def new
    flash[:danger] = ''
      if logged_in?
        redirect_to tasks_path
      end
   end

  def create
    user = User.find_by(email:params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to tasks_path()
    else
      flash.now[:danger] = 'Login failed! Invalid email or password'
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to new_session_path
  end
end
