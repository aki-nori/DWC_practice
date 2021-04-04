class SearchsController < ApplicationController
  def search
  	if params[:search_category] == "1"
  		@users = search_result(User.all, "name")
  		@book = Book.new
  		render "users/index"
  	elsif params[:search_category] == "2"
  		@books = search_result(Book.all, "title")
  		@book = Book.new
  		render "books/index"
  	end
  end

  private

  def search_result model, column # 検索対象のモデルとカラムを引数として指定
  	if params[:search_type] == "1" # 完全一致
		model.where("#{column} LIKE?", params[:word])
	elsif params[:search_type] == "2" # 前方一致
		model.where("#{column}  LIKE?", "#{params[:word]}%")
	elsif params[:search_type] == "3" # 後方一致
		model.where("#{column}  LIKE?", "%#{params[:word]}")
	elsif params[:search_type] == "4" # 部分一致
		model.where("#{column}  LIKE?", "%#{params[:word]}%")
	end
  end

end
