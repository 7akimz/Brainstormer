module ApplicationHelper

  def verfiy_user?(user)
    current_user == user
  end

end
