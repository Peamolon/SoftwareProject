class Team < ApplicationRecord
    has_many :members, class_name: 'Member', foreign_key: 'team_id'
    has_many :users, through: :members
    before_create :validate_team_size
    has_many :team_invitations, class_name: 'TeamInvitation', foreign_key: 'team_id'
    validates :name, presence: true, uniqueness: true

    def has_captain?
        captain.present?
    end

    def set_new_captain!
        @new_captain = self.members.sample.add_role :captain if self.members.present?
    end

    private  
    def validate_team_size
        return if members.blank?
        errors.add("Team size must be between 1 and 3") if members.count > 3
    end

end
