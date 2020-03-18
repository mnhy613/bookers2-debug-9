class BookCommentsController < ApplicationController

  def create
      @books = Book.all
      @new = Book.new
      @book = Book.find(params[:book_id])
      @book_comment = current_user.book_comments.new(book_comment_params)
      @book_comment.book_id = @book.id
      
      if @book_comment.save 
        flash[:success] = "You have commented  successfully."
        redirect_to book_path(@book)
      else 
        render template:'books/show'
      end
  end
  
  def destroy
    book = Book.find(params[:book_id])
    # @url = request.referer
    book_comment = current_user.book_comments.find_by(book_id: book.id)
    book_comment.destroy
    # if @url.include?("books/")
   
    # redirect_to book_path(book)
    # else
    redirect_to request.referrer || root_url
    flash[:success] = "successfully delete comment!"
    # redirect_to books_path
    
  end
  
  
  private
  def book_comment_params
      params.require(:book_comment).permit(:comment)
  end

end
