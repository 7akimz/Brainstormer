module UsersHelper
  def carrierwave_tag(user, thumb = false)
    if thumb
      image_tag user.image_url(:thumb).to_s
    else
      image_tag user.image_url.to_s
    end
  end
end
