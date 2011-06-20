class Worker < ActiveRecord::Base
  
  # Worker associations with Team model and Company model
  belongs_to :team
  belongs_to :company

  # Attributes that can be mass assigned
  attr_accessible :company_id

  # Worker model validations
  validates :team_id,     :presence => true
  validates :company_id,  :presence => true
end
