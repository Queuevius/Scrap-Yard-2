class HaveAttachment < ApplicationRecord
  mount_uploader :image, HaveUploader
  belongs_to :have

end
