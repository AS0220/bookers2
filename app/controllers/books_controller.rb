class BooksController < ApplicationController
  before_action :ensure_current_user, {only: [:edit, :update]}
  def new
    @book =Book.new
  end
  def create
    @book = Book.new(book_params)
    @book.user_id=current_user.id
    if@book.save
      flash[:success] = 'Book was successfully created'
      redirect_to book_path(@book.id)
    else
      @books=Book.all
      @user=current_user
      render :index
    end
  end
  def index
    @book=Book.new
    @books=Book.all
    @user=current_user
  end

  def show
    @book_new = Book.new
    @book=Book.find(params[:id])
    @user=current_user
  end

  def edit
    @book =Book.find(params[:id])
  end

  def destroy
    @book=Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def update
    @book = Book.find(params[:id])
    if@book.update(book_params)
    flash[:success] = 'Book was successfully updated'
    redirect_to book_path(@book)
    else
      render:edit
    end
  end



  private
  # ストロングパラメータ
  def ensure_current_user
    @book = Book.find(params[:id])
    if current_user != @book.user
      flash[:notice]="権限がありません"
      redirect_to books_path
    end
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
