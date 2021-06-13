class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :current_user_check, only: [:edit, :update]

  def index
    @users = User.all.includes(:books)
    @book = current_user.books.build
    @user = current_user
  end

  def show
    @books = @user.books.reverse_order
    @book = current_user.books.build
  end

  def edit;end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "successfully"
    else
      render :edit
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def current_user_check
    unless @user == current_user
      redirect_to current_user, notice: '他人のページにはアクセスできません'
    end
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
