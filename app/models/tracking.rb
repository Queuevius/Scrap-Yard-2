class Tracking < ApplicationRecord
  belongs_to :post, optional: true
end
