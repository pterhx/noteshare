class Comment < ActiveRecord::Base
  attr_accessible :text, :user_id
  # Relationships
  belongs_to :note
end
