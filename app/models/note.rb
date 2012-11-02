class Note < ActiveRecord::Base
  attr_accessible :course_id, :data, :filename, :rating, :title, :type, :user_id
  # Relationships
  belongs_to :course
end
