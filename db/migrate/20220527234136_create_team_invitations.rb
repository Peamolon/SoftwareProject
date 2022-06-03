class CreateTeamInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :team_invitations do |t|
      t.date :invited_at
      t.references :member, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.date :accepted_at

      t.timestamps
    end
  end
end
