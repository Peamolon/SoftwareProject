class Member < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id', optional: false
  belongs_to :team, class_name: 'Team', foreign_key: 'team_id', optional: true
  validates :user_id, presence: true
  validates :framework, presence: true

  scope :with_no_team, -> { where(team_id: nil) }
end
