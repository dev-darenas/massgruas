class Picture < ApplicationRecord
  acts_as_paranoid
  belongs_to :imageable, polymorphic: true

  mount_uploader :image, ImageUploader
  mount_uploaders :attachments, ImageUploader
end
