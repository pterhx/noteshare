class Note < ActiveRecord::Base
  attr_accessible :course_id, :filename, :rating, :title, :user_id
  # Relationships
  belongs_to :course
  
  mount_uploader :filename, FileUploader

end
