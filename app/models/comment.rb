class Comment < ActiveRecord::Base
  attr_accessible :text, :note_id, :user_id
  # Relationships
  belongs_to :note
  belongs_to :user
end
