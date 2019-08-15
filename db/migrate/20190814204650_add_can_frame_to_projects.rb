class AddCanFrameToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :can_frame, :boolean, default: true
  end
end
