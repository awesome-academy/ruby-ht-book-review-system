class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  has_one :user_profile
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :markers
  has_many :reviews
  has_many :comments
  has_many :likes
  has_many :activities

  accepts_nested_attributes_for :user_profile

  def recent_activities limit
    activities.order("created_at DESC").limit limit
  end
end
