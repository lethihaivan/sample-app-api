class User < ApplicationRecord
  validates :name, presence: true,
  length: {maximum: Settings.user.name.max_length}
 validates :email, presence: true,
  length: {maximum: Settings.user.email.max_length},
  format: {with: Settings.user.email.regex}
 validates :password, presence: true,
  length: {minimum: Settings.user.password.min_length}

  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
                                  foreign_key: :follower_id,
                                  dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
                                   foreign_key: :followed_id,
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_secure_password
  scope :newest, ->{order created_at: :desc}
  
  def follow other_user
    following << other_user
  end
end
