class AddNameToIssue < ActiveRecord::Migration[5.0]
  def change
    add_column :issues, :name, :string
  end
end
