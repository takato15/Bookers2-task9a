class Book < ApplicationRecord
	belongs_to :user

  # attachment :profile_image

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
