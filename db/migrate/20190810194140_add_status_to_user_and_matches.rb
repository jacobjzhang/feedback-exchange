class AddStatusToUserAndMatches < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :status, :string, default: 'idle'
    add_column :matches, :status, :string, default: 'pending'
  end
end
