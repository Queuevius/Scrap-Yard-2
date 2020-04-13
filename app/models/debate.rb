class Debate < ApplicationRecord
  belongs_to :token
  belongs_to :post, optional: true
  has_many :arguments
end
