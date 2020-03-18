class Room < ApplicationRecord
  belongs_to :user, optional: true
  has_many :messages, dependent: :destroy,
         inverse_of: :room
  has_many :users, {:through=>:messages, :source=>"user"}
  has_many :rooms, through: :messages

end