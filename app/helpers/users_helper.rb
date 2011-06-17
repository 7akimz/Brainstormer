module UsersHelper

  def carrierwave_tag(user, size = "thumb")
    if size == "thumb"
      image_tag user.image_url(:thumb).to_s
    elsif size == "small"
      image_tag user.image_url(:small).to_s
    else
      image_tag user.image_url.to_s
    end
  end

end
