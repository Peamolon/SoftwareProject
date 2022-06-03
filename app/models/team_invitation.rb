class TeamInvitation < ApplicationRecord
  belongs_to :member, class_name: 'Member', foreign_key: 'member_id'
  belongs_to :team, class_name: 'Team', foreign_key: 'team_id'
  validates :member_id, presence: true
  validates :team_id, presence: true
end
