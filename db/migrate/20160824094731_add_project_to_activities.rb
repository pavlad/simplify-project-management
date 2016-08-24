class AddProjectToActivities < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :project_id, :integer
    add_column :activities, :text, :text
  end
end
