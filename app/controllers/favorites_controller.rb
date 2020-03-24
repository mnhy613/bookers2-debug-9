class FavoritesController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    @url = request.referer
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save
    # if @url.include?("books/")
    #    redirect_to book_path(book)
    # else

  
  redirect_to request.referrer || root_url

   end

  def destroy
    book = Book.find(params[:book_id])
    @url = request.referer
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    # if @url.include?("books/")
   
    # redirect_to book_path(book)
    # else
    redirect_to request.referrer || root_url
 
    
  end

  private

  def set_variables
    @book = Book.find(params[:book_id])
    @id_name = "#like-link-#{@book.id}"
  end

end
