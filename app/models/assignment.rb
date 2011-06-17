class Assignment < ActiveRecord::Base

  # Setup assoications with other models 
  belongs_to :team
  belongs_to :project
	
  # Setup attributes that will be mass-assigned
  attr_accessible :project_id

  # Assignments validations
  validates :team_id,     :presence => true
  validates :project_id,  :presence => true
end
