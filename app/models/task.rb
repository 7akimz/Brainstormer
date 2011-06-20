class Task < ActiveRecord::Base

  # Task association with project
  belongs_to :project

  # Allow the attributes that will be mass assigned
  attr_accessible :name, :description, :priority, :progress,
    :start_date, :due

  # Task validation
  validates :name,        :presence => true,
                          :length => { :maximum => 50 }

  validates :description, :presence => true
  
  validates :start_date,  :presence => true

  validates :due,         :presence => true

  validates :priority,    :presence => true,
                          :inclusion => { :in => 0..6 }
  
  validates :progress,    :presence => true,
                          :numericality => true,
                          :inclusion => { :in => 0..100 }

  scope :finished_tasks, where("due > #{Date.today}")
  
  PRIORITY_NAMES = {
    1 => "Very High",
    2 => "High",
    3 => "Medium",
    4 => "Low", 
    5 => "Very Low"
  }

  def priority_name
    PRIORITY_NAMES[priority]
  end

  def self.priority_name_options
    PRIORITY_NAMES.to_a.sort
  end
  
end
