class Note < ApplicationRecord
  belongs_to :token
  belongs_to :post, optional: true
end
