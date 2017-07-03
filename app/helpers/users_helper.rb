module UsersHelper
  
  # Return gravatar (thumbnail) for the user.
  def gravatar_for(user, options = { size: 80 } )
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    # This actually returns the thumbnail itself, so that the gravatar_for 
    # method returns an image.
    image_tag(gravatar_url, alt: user.name, class: "gravatar") 
  end
end
