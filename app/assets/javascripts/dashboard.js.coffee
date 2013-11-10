$ ->
  $('.basic-cart').popover({ html: true, trigger: 'hover', placement: 'left', container: '#wrap' })

  if (/msie/.test(navigator.userAgent.toLowerCase()))
    $('#featured_apps .product-wrapper').hover(
      ->
        $(this).find('.body:visible').hide()
        $(this).find('.product-cart').animate({width: '0px'}, 200, ->
          $(this).find('.image, .body').toggle()
        ).animate({width: '268px'}, 200)
      ->
        $(this).find('.product-cart').animate({width: '0px'}, 200, ->
          $(this).find('.image, .body').toggle()
        ).animate({width: '268px'}, 200)
    )


  $('.search-panel :checkbox').change ->
    container = $('.search-categories')
    if this.checked
      container.append(' ')
      li = $('<li/>', { html: $(this).parent().text(), class: 'label label-info', id: 'label_' + this.id }).appendTo(container)
      label = $('<label/>', { for: this.id, text: '×' }).appendTo(li)
    else
      container.find('#label_' + this.id).remove()
