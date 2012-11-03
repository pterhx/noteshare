class School < ActiveRecord::Base
  attr_accessible :name

  # Relationships
  has_many :courses
  
  # Scopes
    
end
