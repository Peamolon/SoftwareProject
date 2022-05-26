class Admin < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  validates :user_id, presence: true
end
