class Question < ActiveRecord::Base
  validates :issue, presence: true
  has_many :photos
  has_many :answers
end
