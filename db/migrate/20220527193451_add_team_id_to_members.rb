class AddTeamIdToMembers < ActiveRecord::Migration[7.0]
  def change
    add_reference :members, :team, index: true
  end
end
