class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :job_title, :string
    add_column :users, :mobile_phone, :string
    add_column :users, :phone, :string
    add_column :users, :description, :text
    add_column :users, :profile_picture, :string
    add_reference :users, :company, foreign_key: true
    add_column :users, :is_admin, :boolean
    add_column :users, :is_owner, :boolean
  end
end
