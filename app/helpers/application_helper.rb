module ApplicationHelper
  
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "Did Done Do").join(" - ")
      end
    end
  end
  
end
