class ChangeDefaultValueIsResolvedToIssues < ActiveRecord::Migration[5.0]
  def change
    change_column_default(:issues, :is_resolved, false)
  end
end
