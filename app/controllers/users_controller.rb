class UsersController < ApplicationController

  before_filter :require_user

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Logged in succesfully"
    redirect_to @user
    else
      render 'new'
    end
  end


end
