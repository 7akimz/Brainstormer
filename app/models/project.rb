class Project < ActiveRecord::Base
  # Project assoication with the task
  has_many :tasks

  # Project assoication with the client
  belongs_to :client

  # Project assoication with the Team model through the join table
  # assignments
  has_many :assignments
  has_many :teams, :through => :assignments

  # todo: Setup accessible (or protected) attributes for your model
end
