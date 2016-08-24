class AddAssignmentConsultantIdToActivities < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :assignment_consultant_id, :integer
  end
end
