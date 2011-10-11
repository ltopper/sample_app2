module UsersHelper

  def gravatar_for(user, options = { :size => 50 })
    # 1) assign an alternate image to be their name, 
    #   if there is no image assigned
    # 2) set the CSS class of the resulting Gravatar
    # 3) passes the options hash using the :gravatar key,
    #   which is how to set the options in the documentation
    #   note: default option for the size of the Gravatar using
    #         option { :size => 50 }
    
    gravatar_image_tag(user.email.downcase, :alt => user.name,
                                            :class => 'gravatar',
                                            :gravatar => options)
  end
end
