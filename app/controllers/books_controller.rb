class BooksController < ApplicationController
	def new
	end

	def create
		@new_book = Book.new(book_params)
		@new_book.user_id = current_user.id
		if @new_book.save
			flash[:notice] = 'You have creatad book successfully.'
			redirect_to books_path
		else
			@books = Book.all
			render action: :index
		end
	end

	def index
		@new_book = Book.new
		@books = Book.all
	end

	def show
		@new_book = Book.new
		@book = Book.find(params[:id])
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
			flash[:notice] = 'You have updated book successfully.'
			redirect_to book_path(@book)
		else
			render action: :edit
		end
	end

	def destroy
		book = Book.find(params[:id])
		book.destroy
		redirect_to books_path
	end

	def top
	end

	def about
	end

	private

	def book_params
		params.require(:book).permit(:title, :body)
	end
end
