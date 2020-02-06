class Room < ApplicationRecord
  has_many :messages, dependent: :destroy,
         inverse_of: :room
  belongs_to :user, :class_name => 'User', :foreign_key => "sender_id"

end