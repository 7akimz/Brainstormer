module TeamsHelper

  # Check to see if the user is a team leader
  # or a manager
  def privileged?(user)
    return false unless authorized_user?(user)
  end

  def authorized_user?(user)
    user.role == 4 || user.role == 2
  end

end

