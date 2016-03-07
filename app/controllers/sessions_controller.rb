
class SessionsController < ApplicationController
  def new
   end

  def create_oauth
    user = User.find_by username: env["omniauth.auth"].info.nickname
    if user and not user.banned
      session[:user_id] = user.id
      redirect_to user, notice: 'Welcome back!'
    else

    end
  end



  def create
    user = User.find_by username: params[:username]

    if user and user.banned
      redirect_to :back, notice: "You are banned!!!" and return
    elsif user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user, notice: 'Welcome back!'
    else
      redirect_to :back, notice: "Username and/or password mismatch"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end