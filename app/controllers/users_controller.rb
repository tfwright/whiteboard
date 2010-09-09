class UsersController < ApplicationController
  
  before_filter :ensure_owner
  
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
  
  private
  
  def ensure_owner
    unless current_user.id == params[:id]
      redirect_to root_path, :warning => "You don't have permission."
    end
  end
  
end
