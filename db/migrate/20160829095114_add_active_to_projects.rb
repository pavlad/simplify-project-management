class AddActiveToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :active, :boolean
  end
end
