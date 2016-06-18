class AnswerVote < ActiveRecord::Base
	include PublicActivity::Common
	# tracked owner: ->(controller, model) { controller && controller.current_user }

  belongs_to :answer
  belongs_to :user

  validates_uniqueness_of :answer_id, scope: :user_id
  validates_inclusion_of :value, in: [1, -1]
  # validate :ensure_not_author

  # def ensure_not_author
  # 	errors.add :user_id, "不能给自己投票" if answer.user_id == user_id
  # end
end
