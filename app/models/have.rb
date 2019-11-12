class Have < ApplicationRecord
  has_many :have_attachments
  accepts_nested_attributes_for :have_attachments

  belongs_to :user
end
