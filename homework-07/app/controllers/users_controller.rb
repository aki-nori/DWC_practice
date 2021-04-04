class UsersController < ApplicationController
	before_action :baria_user, only: [:update, :edit]

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def index
  	@users = User.all #一覧表示するためにUserモデルのデータを全  て変数に入れて取り出す。
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def edit
  	@user = User.find(params[:id])
    unless @user = current_user
      redirect_to current_user
    end
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  		redirect_to user_path(@user), :notice => "successfully updated user!"
  	else
  		render :edit
  	end
  end

  def follows
    @users = User.find(params[:id]).followers
  end

  def followers
    @users = User.find(params[:id]).followings
  end

  private

  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image, :postcode, :prefecture_name, :address_city, :address_street, :address_building)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
  def baria_user
  	unless params[:id].to_i == current_user.id
  		redirect_to user_path(current_user)
  	end
  end

end
