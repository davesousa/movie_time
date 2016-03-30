class Admin::UsersController < ApplicationController
  before_action :require_admin

  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path
    else
      render :create
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to admin_user_path(@user)
    else
      redirect_to edit_admin_user_path(@user)
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def require_admin
     unless current_user.admin?
       redirect_to root_path
     end
   end

   def user_params
     params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
   end

end
