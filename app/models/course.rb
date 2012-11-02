class Course < ActiveRecord::Base
  attr_accessible :name, :school_id
  # Relationships
  belongs_to :school
  has_many :notes
end
