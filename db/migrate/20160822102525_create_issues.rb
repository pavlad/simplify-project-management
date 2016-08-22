class CreateIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :issues do |t|
      t.string :label
      t.text :description
      t.references :project, foreign_key: true
      t.boolean :is_resolved
      t.text :comment

      t.timestamps
    end
  end
end
