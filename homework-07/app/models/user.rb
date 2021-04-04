class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # 当該UserがいいねしたBooksを取得できる
  has_many :favorited_books, through: :favorites, source: :book
  has_many :book_coments, dependent: :destroy
  # 当該UserがコメントしたBooksを取得できる
  has_many :book_commented_books, through: :book_coments, source: :book

  # 自分がフォローしているユーザとの関連
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower

  # 自分がフォローされているユーザとの関連
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  attachment :profile_image, destroy: false

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}

  # validates :postal_code, length: {is: 7}

  def already_favorited?(book)
    self.favorites.exists?(book_id: book.id)
  end

  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  def address_string
    pref = JpPrefecture::Prefecture.find self.prefecture_code
    "#{pref.name}#{self.address_city}#{self.address_street}#{self.address_building}"
  end

end
