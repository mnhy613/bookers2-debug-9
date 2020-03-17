class BooksController < ApplicationController
  before_action :authenticate_user!
  def show
		@book = Book.find(params[:id])
		@user = @book.user
  end

  def index
		@books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
		@book = Book.new
  end

  def create
		@book = Book.new(book_params) 
		@book.user = current_user
		if @book.save 
			flash[:success] = "You have creatad book successfully."
  		redirect_to @book, notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
  		@books = Book.all
  		render 'index'
  	end
  end

  def edit
		@book = Book.find(params[:id])
		if current_user.id != @book.user.id
			redirect_to books_path
		end
  end



  def update
  	@book = Book.find(params[:id])
		if @book.update(book_params)
			flash[:good] = "Book was successfully updated."
  		redirect_to book_path(@book)
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

  def destroy
		@book = Book.find(params[:id])
  	@book.delete
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end

end
