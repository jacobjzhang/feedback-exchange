class AddStageTypeToProjectsAndMatches < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :stage_type, :string, default: 'real', index: true
    add_column :users, :stage_type, :string, default: 'real', index: true
  end
end
