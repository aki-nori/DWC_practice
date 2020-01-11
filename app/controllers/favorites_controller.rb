class FavoritesController < ApplicationController
	def create
		@favorite = Favorite.new(user_id: params[:user_id], book_id: params[:book_id])
		path_redirect(@favorite.save)
	end

	def destroy
		@favorite = Favorite.find_by(user_id: params[:user_id], book_id: params[:book_id])
		path_redirect(@favorite.destroy)
	end

	private

	def favorite_params
  		params.require(:favorite).permit(:book_id)
    end

    # リダイレクト先を遷移元で条件分岐
    def path_redirect action_result
    	path = Rails.application.routes.recognize_path(request.referer)
		if action_result
			if path[:controller] == "books" && path[:action] == "show"
				redirect_to @favorite.book
			elsif path[:controller] == "books" && path[:action] == "index"
				redirect_to books_path
			elsif path[:controller] == "users" && path[:action] == "show"
				redirect_to @favorite.book.user
			end
		else
			render "#{path[:controller]}/#{path[:action]}"
		end
    end


end
