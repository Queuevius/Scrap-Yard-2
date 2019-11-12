class Want < ApplicationRecord
  has_many :wants_attachments
  accepts_nested_attributes_for :wants_attachments

  belongs_to :user
end
