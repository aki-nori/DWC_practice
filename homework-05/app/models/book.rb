class Book < ApplicationRecord
	# has_many :user
	belongs_to :user
	has_many :favorites, dependent: :destroy
	# 当該BookをいいねしたUsersを取得できる
	has_many :favorited_users, through: :favorites, source: :user
	has_many :book_comments, dependent: :destroy
	# 当該BookにコメントしたUsersを取得できる
	has_many :book_comented_users, through: :book_coments, source: :user
	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
