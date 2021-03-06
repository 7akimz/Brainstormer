module ApplicationHelper

  def admin_or_same?(user)
    same_user?(user) || current_user.admin?
  end
  # Check if the current user 
  # is the same user of the 
  # resource
  def same_user?(user)
    current_user == user
  end
  
  #check if user is a manager or team leader
  def authorized_user?(user)
    user.role == 5 || user.role == 2
  end

end
