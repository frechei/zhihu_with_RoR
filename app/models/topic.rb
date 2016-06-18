class Topic < ActiveRecord::Base
	include PublicActivity::Common
	has_and_belongs_to_many :questions

	# 关注话题的人
  has_many :topic_followers, class_name: "FollowTopic",
    foreign_key: "followed_tp_id", dependent: :destroy
  has_many :tp_followers, through: :topic_followers
end
