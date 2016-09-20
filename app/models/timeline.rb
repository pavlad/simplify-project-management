class Timeline < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_attachments :timeline_files, maximum: 20
  default_scope { order('date', 'created_at') }
end
