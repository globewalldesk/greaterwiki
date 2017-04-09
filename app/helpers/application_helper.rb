module ApplicationHelper
  
  def full_title (page_title = "")
    page_title.empty? ? "GreaterWiki" : "GreaterWiki | #{page_title}"
  end
  
end
