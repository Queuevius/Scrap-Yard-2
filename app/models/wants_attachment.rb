class WantsAttachment < ApplicationRecord
  mount_uploader :image, WantPicUploader
  belongs_to :want

end
