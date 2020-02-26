class Room < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy,
         inverse_of: :room
  has_many :users, {:through=>:messages, :source=>"user"}

end