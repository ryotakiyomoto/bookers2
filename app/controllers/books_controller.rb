class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :current_user_check, only: [:edit, :update, :destroy]

  def index
    @books = Book.all
    @book_new = current_user.books.build
  end

  def show
    @user = @book.user
    @book_new = current_user.books.build
  end

  def create
  	@book = current_user.books.build(book_params)
    if @book.save
      redirect_to @book, notice: 'successfully'
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    unless @book.user == current_user
      redirect_to request.referer, notice: '他人のページにはアクセスできません'
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'successfully'
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: 'successfully'
  end

  private
  def set_book
  	@book = Book.find(params[:id])
  end

  def current_user_check
    unless @book.user == current_user
      redirect_to books_path, notice: '他人のページにはアクセスできません'
    end
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
