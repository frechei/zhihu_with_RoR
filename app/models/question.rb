class Question < ActiveRecord::Base
  validates :issue, presence: true
  has_many :photos
end
