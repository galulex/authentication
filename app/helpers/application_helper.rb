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
    params[:id] == 'registration' && params[:commit] && @report.users.present?
  end

  def user_product_rating(product, user)
    rate = product.ratings.find_by_user_id(user.id)
    render_rating(rate.score) if rate
  end

  def render_rating(score)
    html = ''
    5.times do |i|
      html << content_tag('i', '', class: (i < score ? 'icon-star' : 'icon-star-empty'))
    end
    html.html_safe
  end

  def rating_average(score, element_class = nil)
    html = ''
    5.times do |i|
      if i + 1 <= score
        html << content_tag('i', '', class: "icon-star #{ element_class }")
      else
        klass = (score - i) > 0.4 ? 'icon-star-half-empty' : 'icon-star-empty'
        html << content_tag('i', '', class: "#{ klass } #{ element_class }")
      end
    end
    html.html_safe
  end

end
