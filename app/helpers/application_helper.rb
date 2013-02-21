module ApplicationHelper

  def error_tag(error)
    if error
      content_tag :div, class: "alert alert-error" do
        content_tag :div, error
      end
    end
  end

  def render_title
    return @page_title if @page_title
    title = "#{params[:controller].parameterize('_')}.#{params[:action].parameterize('_')}"
    I18n.t("page_titles.#{title}")
  end

  #TODO Move to registration helper
  def show_csv_button?
    params[:id] == 'registration' && params[:commit]
  end

  def user_rating(product, user_id)
    html = ''
    rate = product.ratings.find_by_user_id(user_id)
    score = rate.score
    5.times do |i|
      html << content_tag('i', '', class: (i < rate.score ? 'icon-star' : 'icon-star-empty'))
    end
    html.html_safe
  end

end
