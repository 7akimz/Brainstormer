class Assignment < ActiveRecord::Base

	# Setup assoications with other models 
  belongs_to :team
  belongs_to :project
	
  # Setup attributes that will be mass-assigned
  attr_accessible :project_id
end
