class RemoveTextFromActivities < ActiveRecord::Migration[5.0]
  def change
    remove_column :activities, :text
  end
end
