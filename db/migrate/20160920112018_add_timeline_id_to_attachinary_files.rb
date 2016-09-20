class AddTimelineIdToAttachinaryFiles < ActiveRecord::Migration[5.0]
  def change
    add_reference :attachinary_files, :timelines, foreign_key: true
  end
end
