module ApplicationHelper
  
  def full_title (page_title = "")
    page_title.empty? ? "Spare Plans" : "Spare Plans | #{page_title}"
  end
  
end
