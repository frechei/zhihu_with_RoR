class FollowQuestion < ActiveRecord::Base
	belongs_to :qs_follower, class_name: "User"
	belongs_to :followed_qs, class_name: "Question"
	validates :qs_follower_id, presence: true
	validates :followed_qs_id, presence: true
end
