class Question < ActiveRecord::Base
  include PublicActivity::Common
  
  validates :issue, presence: true
  has_many :photos
  has_many :answers
  belongs_to :questioner, class_name: "User", inverse_of: :questions
  has_many :comments, as: :commentable
  has_and_belongs_to_many :topics, uniq: true

  # 关注问题的人
  has_many :question_followers, class_name: "FollowQuestion",
    foreign_key: "followed_qs_id", dependent: :destroy
  has_many :qs_followers, through: :question_followers


  attr_accessor :topic_names

  def topic_names=(names)
  	@topic_names = names
  	names.split.each do |name|
  		self.topics << Topic.find_or_initialize_by(name: name)
  	end
  end
end
