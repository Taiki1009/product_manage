class AddNameToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :name, :string, after: :email
  end
end
