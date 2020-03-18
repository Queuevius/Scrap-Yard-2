class Notification < ApplicationRecord
  belongs_to :recipient, class_name: "User"
  belongs_to :actor, class_name: "User", optional: true
  belongs_to :notifiable, polymorphic: true

  has_many :rooms, :through => :messages, :foreign_key => "room_id"

  scope :unread, -> {where(read_at: nil)}
end
