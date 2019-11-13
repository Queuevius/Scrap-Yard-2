class Have < ApplicationRecord
  has_many :have_attachments
  accepts_nested_attributes_for :have_attachments

  has_many :feeds
  accepts_nested_attributes_for :feeds

  belongs_to :user
end
