class Project < ActiveRecord::Base
  # Project assoication with the task
  has_many :tasks

  # Project assoication with the client
  belongs_to :client

  # Project assoication with the Team model through the join table
  # assignments
  has_many :assignments
  has_many :teams, :through => :assignments

  # Setup accessible (or protected) attributes for your model

  attr_accessible :name, :description, :budget, :address, 
                  :side_notes, :start_date, :due

  # Project model validations 
  validates :name,        :presence => true,
                          :uniqueness => true,
                          :length => { :within => 3..60 }

  validates :description, :presence => true

  validates :address,     :presence => true

  validates :budget,      :presence => true

  validates :start_date,  :presence => true

  validates :due,         :presence => true

  # Find all the projects where the due date is greater
  # the Date today
  scope :finished_projects, where("due > #{Date.today}")
end
