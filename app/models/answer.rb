class Answer < ActiveRecord::Base
	include PublicActivity::Common
	# tracked owner: ->(controller, model) { controller && controller.current_user }

  belongs_to :question
  validates :content, presence: true
  belongs_to :replier, class_name: "User", inverse_of: :answers
  has_many :comments, as: :commentable
  belongs_to :user

  has_many :answer_votes

  def self.by_votes	
    select('answers.*,coalesce(value, 0) as votes').
  	joins('left join answer_votes on answer_votes.answer_id=answers.id').
  	order('votes desc')
    # .group('answer_id')
  end

  def votes
  	answer_votes.sum(:value)
  end
end
