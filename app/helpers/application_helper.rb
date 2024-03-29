module ApplicationHelper
  # Logo Helper
  def logo
    image_tag("logo.png", :alt => "Sample App", :class => "round")
  end
  
  def new_logo
    image_tag("new_logo.png", :alt => "Sample App", :class => "round")
  end
  
  # Return a title on a per-page basis
  def title
    base_title = "Louis' Twitter"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}" 
    end
  end
  
end