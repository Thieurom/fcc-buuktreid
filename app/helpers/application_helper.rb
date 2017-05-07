module ApplicationHelper

  # Return the title on a per-page basis
  def page_title(title = "")
    base_title = "Buuktreid | A friendly marketplace for book lovers."
    if title.empty?
      base_title
    else
      title
    end
  end

end
