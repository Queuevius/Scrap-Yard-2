class Message < ApplicationRecord
  belongs_to :user, :class_name => 'User', :foreign_key => "user_id"
  belongs_to :room, inverse_of: :messages

  def as_json(options)
    super(options).merge(user_name: [user.first_name, user.last_name].compact.join(' '))
  end
end
