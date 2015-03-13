# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string(255)
#  last_name       :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  admin           :boolean
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :email,      presence: true, uniqueness: true
  validates :password,   presence: { on: create }, length: { minimum: 6 }, if: :password_digest_changed?

  has_secure_password

  has_many :follower_relations, :class_name => 'Followings', :foreign_key => 'user_id'
  has_many :following_relations, :class_name => 'Followings', :foreign_key => 'follower_id'

  has_many :posts

  def followers
    followers = []

    self.follower_relations.each { |relation| followers << relation.follower }
    followers.uniq
  end

  def following
    following = []

    self.following_relations.each { |relation| following << relation.user }
    following.uniq
  end
end
