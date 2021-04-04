class BookCommentsController < ApplicationController
	def create
		@book_comment = BookComment.new(book_comment_params)
		@book_comment.user_id = current_user.id
		if @book_comment.save
			redirect_to @book_comment.book
		else
			@book = Book.find(@book_comment.book.id)
    		@book_comments = BookComment.where(book_id: @book.id)
			render "books/show"
		end
	end

	def destroy
		@book_comment = BookComment.find(params[:id])
		if @book_comment.destroy
			redirect_to @book_comment.book
		else
			@book = Book.find(@book_comment.book.id)
    		@book_comments = BookComment.where(book_id: @book.id)
			render "books/show"
		end
	end

	private

	def book_comment_params
  		params.require(:book_comment).permit(:book_id, :comment)
    end
end
