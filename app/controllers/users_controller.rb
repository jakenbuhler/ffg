class UsersController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  before_filter :not_self,     :only => :destroy
  
  def index
    @users = User.all
    @title = "Members"
  end
  
  def new
    @user = User.new
    @title = "Sign Up"
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the FFG! Please drink responsibly."
      redirect_to @user
    else
      @title = "Sign Up"
      render 'new'
    end
  end
  
  def edit
    @title = "Edit User"
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      @title = "Edit User"
      render 'edit'
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = "User deleted"
    redirect_to users_path
  end
  
  private
  
    def authenticate
      deny_access unless signed_in?
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
    
    def not_self
      @user = User.find(params[:id])
      redirect_to(root_path) if current_user?(@user)
    end
end
