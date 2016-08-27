class AddProjectToTimeline < ActiveRecord::Migration[5.0]
  def change
    add_reference :timelines, :project, foreign_key: true
  end
end
