class Photo < ActiveRecord::Base
  belongs_to :question
  mount_uploader :image, PhotoUploader
end
