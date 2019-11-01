class Profile < ApplicationRecord
	belongs_to :user
	delegate :full_name, to: :user


	def display_pic 
		if self.user.image.blank?
			self.avatar_url 
		else
			self.user.image
		end
	end
end
