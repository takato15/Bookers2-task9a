class Book < ApplicationRecord

	belongs_to :user

  has_many :post_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :favorited_users, through: :favorites, source: :user


	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}


  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  is_impressionable counter_cache: true

  # def Book.last_week # メソッド名は何でも良いです
    # Book.joins(:favorites).where(favorites: { created_at: 0.days.ago.prev_week..0.days.ago.prev_week(:sunday)}).group(:id).order("count(*) desc")
  # end

  def Book.search(search, model, how)
    if how == "partical"
  	  Book.where("title LIKE ?", "%#{search}%")
    elsif how == "forward"
  	  Book.where("title LIKE ?", "#{search}%")
    elsif how == "backward"
  	  Book.where("title LIKE ?", "%#{search}")
    elsif how == "match"
  	  Book.where("title LIKE ?", "#{search}")
    end
  end

end
