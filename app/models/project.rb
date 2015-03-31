class Project < ActiveRecord::Base
  validates :technologies_used, presence: true
  validates :name, length: { in: 4..255 }
  mount_uploader :image, ScreenshotUploader
end
