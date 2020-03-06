class Tag < ApplicationRecord
	include FriendlyId
  friendly_id :name, use: [:slugged, :history]

	# Associations
	has_many :taggings
	has_many :posts, through: :taggings
	has_many :layers, as: :layerable

	belongs_to :user, :class_name => 'User', :foreign_key => "creator_id"

	def posts_count(layer_id = nil)
	 ["Problem", "Idea", "Proposal"].map! do |post_type|
	 	[post_type, self.posts.where(taggings: { layer_id: layer_id}, posts: {:post_type => post_type}).count]	
	 end
	end

end
