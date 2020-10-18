class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all.order('id ASC')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: 'user created successfully'
    else
      render.new
    end
  end

  def show
    @tasks = Task.all
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'user details updated'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
      @admins = User.admin
    if @admins == 1
      redirect_to admin_users_path, notice: "Atleast one user or admin should remain"
#prevent not to delete logged in user
    elsif @user.id == current_user.id
        redirect_to admin_users_path, notice: "Logged in user cannot be deleted!"
    else
      @user.destroy
      redirect_to admin_users_path, notice: 'User deleted.'
    end
  end
  private

  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password,
                                 :password_confirmation, :admin)
  end
end
