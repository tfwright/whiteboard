class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit 
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to user_path(@user), :notice => "Updated your account information."
    else
      render :action => :edit
    end
  end
  
end
