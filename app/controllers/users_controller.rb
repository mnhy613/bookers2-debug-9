class UsersController < ApplicationController

	before_action :authenticate_user!
  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def index
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
		@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
	
	end
  def edit
		@user = User.find(params[:id])
		if @user.id != current_user.id
    redirect_to user_path(current_user)
	  end
	end

  def update
  	@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:notice] = "You have updated user successfully."
  		redirect_to user_path(@user.id)
  	else
  		render "edit"
  	end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
   
	 def user_params
		params.require(:user).permit(:name, :introduction, :profile_image)
   end

		def book_params
				params.require(:book).permit(:title, :body)
		end

	def correct_user
		@user = User.find(id: params[:id])
			unless @user
				redirect_to new_user_session
			end
	end
end

