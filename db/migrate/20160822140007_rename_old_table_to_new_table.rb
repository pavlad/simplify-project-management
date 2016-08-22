class RenameOldTableToNewTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :consultant_projects, :assignments
  end
end
