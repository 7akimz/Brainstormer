class Company < ActiveRecord::Base

  # Company association with the teams
  has_many :members
  has_many :teams, :through => :members
end
