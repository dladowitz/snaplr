# == Schema Information
#
# Table name: followings
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  follower_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Followings < ActiveRecord::Base
  belongs_to :user
  belongs_to :follower, :class_name => 'User'

  validate :user_id, :follower_id, presence: true

  def posts

  end
end
