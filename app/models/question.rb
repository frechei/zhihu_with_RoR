class Question < ActiveRecord::Base
  validates :issue, presence: true
end
