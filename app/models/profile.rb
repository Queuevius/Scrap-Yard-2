class Profile < ApplicationRecord
	belongs_to :user
	delegate :full_name, to: :user
end
