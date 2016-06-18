class User < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save { self.email = email.downcase }
  before_create :create_activation_digest
  validates :name, presence:true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence:true, format: { with: VALID_EMAIL_REGEX },
      uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  mount_uploader :avatar, AvatarUploader

    def username_for_avatar
    # Translate chinese hanzi to pinyin
    # https://github.com/flyerhzm/chinese_pinyin
    Pinyin.t(self.name)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_token, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  #关注者与被关注者的Relationships
  has_many :active_relationships, class_name: "Relationship",
           foreign_key: "follower_id",
           dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
           foreign_key: "followed_id",
           dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  #关注某个人
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  #取消关注某个人
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  # 跟问题的关联
  has_many :questions
  has_many :answers

  has_many :answer_votes
  # 答案里有多少个赞
  def total_votes
    AnswerVote.joins(:answer).where(user_id: self.id).where(value: 1).sum('value')
  end

  # 跟评论的关联
  has_many :comments

  ####################################################################
  # 关注问题
  has_many :follow_questions, class_name: "FollowQuestion",
    foreign_key: "qs_follower_id", dependent: :destroy
  has_many :followed_qs, through: :follow_questions

  # 关注一个问题
  def follow_a_question(question)
    follow_questions.create(followed_qs_id: question.id)
  end

  # 取消关注一个问题
  def unfollow_a_question(question) 
    follow_questions.find_by(followed_qs_id: question.id).destroy
  end

  # 如果当前用户关注了指定的问题，返回true
  def following_a_question?(question)
    followed_qs.include?(question)
  end

  ####################################################################
  # 关注话题
  has_many :follow_topics, class_name: "FollowTopic",
    foreign_key: "tp_follower_id", dependent: :destroy
  has_many :followed_tp, through: :follow_topics

  # 关注一个话题
  def follow_a_topic(topic)
    follow_topics.create(followed_tp_id: topic.id)
  end

  # 取消关注一个话题
  def unfollow_a_topic(topic)
    follow_topics.find_by(followed_tp_id: topic.id).destroy
  end

  # 如果当前用户关注指定话题，返回true
  def following_a_topic?(topic)
    followed_tp.include?(topic)
  end

  private
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

end
