class CreateTimelines < ActiveRecord::Migration[5.0]
  def change
    create_table :timelines do |t|
      t.string :title
      t.date :date
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
