class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable,:validatable

  #  住所登録
  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end


  # ユーザーをフォローする関数
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーをフォロー解除する関数
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしているかを調べる関数
  def following?(user)
    following.include?(user)
  end

  def self.search(search,word)
		if search == "forward_match"
						@user = User.where("name LIKE?","#{word}%")
		elsif search == "backward_match"
						@user = User.where("name LIKE?","%#{word}")
		elsif search == "perfect_match"
						@user = User.where("#{word}")
		elsif search == "partial_match"
						@user = User.where("name LIKE?","%#{word}%")
		else
						@user = User.all
		end
  end
 
  # has_many :active_relationships, class_name:  "Relationship",
  # foreign_key: "follower_id",
  # dependent:   :destroy

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得
  
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得

  has_many :following, through: :follower, source: :followed
  
  has_many :followers, through: :followed, source: :follower


  # has_many :passive_relationships, class_name:  "Relationship",
  # foreign_key: "followed_id",
  # dependent:   :destroy
  
 

  has_many :books,dependent: :destroy
  has_many :book_comments,dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image, destroy: false

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}
end
