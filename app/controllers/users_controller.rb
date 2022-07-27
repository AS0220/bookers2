class UsersController < ApplicationController
  before_action :ensure_current_user, {only: [:edit, :update]}
  def new
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
     @user = User.find(params[:id])
  end

  def index
    @users =User.all
    @user=current_user
    @book= Book.new

  end

  def update
    @user =  User.find(params[:id])
    if@user.update(user_params)
    flash[:success] = 'User was successfully updated'
    redirect_to user_path(@user)
    else
      render:edit
    end

  end


  private

  def ensure_current_user
    @user = User.find(params[:id])
    if current_user.id != @user.id
      flash[:notice]="権限がありません"
      redirect_to user_path(current_user)
    end
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
