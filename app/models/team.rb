class Team < ActiveRecord::Base
  has_many :events, :dependent => :destroy
  # Team associations which link the Team model with the User model
  has_many :members, :dependent => :destroy
  has_many :users, :through => :members, :uniq => true

  # Team association which links the Team model 
  # with the Project model
  has_many :assignments, :dependent => :destroy
  has_many :projects, :through => :assignments, :uniq => true

  # Team association with Company model through Worker 
  # model
  has_many :workers, :dependent => :destroy
  has_many :companies, :through => :workers, :uniq => true

  # String values for the role instead of the integers values
  TEAM_ROLE = {
    0 => "Analyst Team",
    1 => "Developer Team",
    2 => "Mixed Team",
    3 => "Software Engineer Team"
  }

  # Allow the attributes the will be mass assigned
  attr_accessible :name, :role, :email

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # Setup validation for the name
  validates :name,    :presence => true,
                      :length => { :maximum => 30 },
                      :uniqueness => true

  # Setup validation for the role
  validates :role,    :presence => true,
                      :inclusion => { :in => 0..3 }

  # Setup validation for the email
  validates :email,   :presence => true,
                      :format       => { :with => EMAIL_REGEX },
                      :uniqueness   => { :case_sensitive => false }

  # Get the corresponding string value of the integer value of the 
  # role
  def team_role
    TEAM_ROLE[role]
  end
  
  # Convert the dobule paired values of the roles into array
  # and sort them to be used as a data in the drop down list
  def self.role_name_options
    TEAM_ROLE.to_a.sort
  end
  
  # Check if a team is assigned to project by searching the 
  # association table assignment
  def is_assigned_to?(project)
    Assignment.find_by_team_id_and_project_id(self.id, project.id)
  end

  # Assign a project to a team
  def assign_to!(project)
    self.projects << project unless self.is_assigned_to?(project)
  end

  # Unassign a team from a project
  def unassign_from!(project)
    self.projects.delete(project) if self.is_assigned_to?(project)
  end

  # Check if a team is related to a company by searching the 
  # association table worker
  def is_part_of?(company)
    Worker.find_by_team_id_and_company_id(self.id, company.id)
  end

  # Associate a team with company
  def work_in!(company)
    self.companies << company unless self.is_part_of?(company)
  end

  # Remove a team from company
  def retire_from!(company)
    self.companies.delete(company) if self.is_part_of?(company)
  end

end
