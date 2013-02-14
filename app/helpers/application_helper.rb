module ApplicationHelper

  def error_tag(error)
    if error
      content_tag :div, class: "alert alert-error" do
        content_tag :div, error
      end
    end
  end

  def render_title
    title = "#{params[:controller].parameterize('_')}.#{params[:action].parameterize('_')}"
    I18n.t("page_titles.#{title}")
  end

end
