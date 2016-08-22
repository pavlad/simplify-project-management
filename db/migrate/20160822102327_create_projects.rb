class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.integer :man_days
      t.integer :project_manager_id
      t.references :client, foreign_key: true

      t.timestamps
    end
  end
end
