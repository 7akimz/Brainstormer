module TeamsHelper

  # Check to see if the user is a team leader
  # or a manager
  def privileged?(user)
    return false unless authorized_user?(user)
  end

end

