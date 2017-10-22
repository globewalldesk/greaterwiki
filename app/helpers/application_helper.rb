module ApplicationHelper
  
  def full_title (page_title = "")
    page_title.empty? ? "Start This!" : "Start This! | #{page_title}"
  end
  
end
