class Room < ApplicationRecord

  belongs_to :user
  belongs_to :second_user, class_name: 'User'
  has_many :messages

end
