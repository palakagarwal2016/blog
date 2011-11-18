class SessionsController < ApplicationController

  def new
  end

  def create
      user = User.authenticate(params[:session][:email],
                               params[:session][:password])
      if user.nil?
        flash.now[:error] = "Invalid email/password combination."
        render 'new'
      else
        sign_in user
        redirect_to posts_url, :notice => "Logged in as #{user.name}"
      end
    end

  def destroy
    sign_out
    redirect_to root_url, :notice => "Logged out"
  end

end
