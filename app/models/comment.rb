class Comment < ActiveRecord::Base
  attr_accessible :text, :note_id
  # Relationships
  belongs_to :note
end
