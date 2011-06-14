module ApplicationHelper

  def same_user?(user)
    current_user == user
  end

end
