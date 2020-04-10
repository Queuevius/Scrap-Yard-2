class Argument < ApplicationRecord
  belongs_to :debate
  has_many :ratings, as: :rateable

  def avg_rating
    ( self.ratings.map(&:score).sum / ( self.ratings.empty? ? 1 : self.ratings.count  ) )
  end
end
