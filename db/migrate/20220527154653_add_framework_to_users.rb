class AddFrameworkToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :framework, :string
  end
end
