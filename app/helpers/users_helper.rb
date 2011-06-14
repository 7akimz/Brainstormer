module UsersHelper

  def carrierwave_tag(user)
      image_tag user.image_url(:thumb).to_s
  end

end
