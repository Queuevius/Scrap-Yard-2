class Post < ApplicationRecord
	# Use slugs instead of DB IDs in URLs
  include FriendlyId
  friendly_id :title, use: :slugged

	# Associations
	belongs_to :user, foreign_key: "creator_id", class_name: "User"
	has_many :taggings
	has_many :tags, through: :taggings
	has_many :ideas, -> { where(post_type: 'Idea')} , class_name: "Post", foreign_key: "parent_post_id"
	has_many :proposals, -> { where(post_type: 'Proposal')}, class_name: "Post", foreign_key: "parent_post_id"
	has_many :problems, -> { where(post_type: 'Problem')} , class_name: "Post", foreign_key: "parent_post_id"
	has_many :layers, as: :layerable
	has_many :tokens	
	has_many :ratings, as: :rateable
	has_many :trackings


	# Scopes	
	scope :type, ->(post_type){ where(post_type: post_type )}
	scope :with_tags, -> (tags) { joins(:tags).where("tags.name IN (?)",tags) }
	# Validations 
	validates :title, :post_body, presence: true



	def all_tags=(names)
		self.tags = names.split(",").map do |name|
		    Tag.where("name ILIKE ?",name.strip).first_or_create!(name: name.strip)
		end
	end

	def all_tags
	  self.tags.map(&:name).join(", ")
	end

	def parent_slug
		Post.find(self.parent_post_id).slug 
	end 

	def area
		self.tags.first
	end

	def avg_rating 
		( self.ratings.map(&:score).sum / ( self.ratings.empty? ? 1 : self.ratings.count  ) )
	end

end
