class FollowTopic < ActiveRecord::Base
	belongs_to :tp_follower, class_name: "User"
	belongs_to :followed_tp, class_name: "Topic"
	validates :tp_follower_id, presence: true
	validates :followed_tp_id, presence: true
end
