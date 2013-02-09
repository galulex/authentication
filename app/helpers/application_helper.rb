module ApplicationHelper

  def error_tag(error)
    if error
      content_tag :div, class: "alert alert-error" do
        content_tag :div, error
      end
    end
  end

end
