class Member < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id', optional: false
  validates :user_id, presence: true
  validates :framework, presence: true
end
