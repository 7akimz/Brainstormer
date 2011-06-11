class Member < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  # Setup validation for the user id, in order to be present
  validates :user_id, :presence => true

  # Setup validation for the team id, in order to be present
  validates :team_id, :presence => true
end
