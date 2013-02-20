$ ->
  $('#filter_month, #filter_range').change ->
    $('.report-filters .range, .report-filters .month').toggle()

  $('.role-select').change ->
    $.ajax({url: $(this).data('url'), type: 'PUT', dataType: 'script', data: { role_id: $(this).val() }})

  $('.add-user').click (e)->
    fields = $(this).siblings('li:first').clone()
    fields.find('input').val('')
    fields.find('.error').removeClass('error')
    fields.find('.help-inline').remove()
    fields.insertBefore($(this))
    $('.remove-user').show()
    e.preventDefault()

  $(document).on 'click', '.remove-user', (e)->
    $(this).parents('li').remove()
    $('.remove-user').hide() if $('.remove-user').length == 1
    e.preventDefault()

  $.rails.allowAction = (element) ->
    message = element.data('confirm')
    return true unless message
    $link = element.clone().removeAttr('class').removeAttr('data-confirm').addClass('btn').addClass('btn-danger').text('Confirm')
    modal_html = """
                   <div class="modal-header">
                     <a class="close" data-dismiss="modal">×</a>
                     <h3>#{element.data('title')}</h3>
                   </div>
                   <div class="modal-body confirmation">
                     <p>#{message}</p>
                     <div class="text-right"><a data-dismiss="modal" class="btn">Cancel</a> </div>
                   </div>
                 """
    $modal_html = $(modal_html)
    $modal_html.find('.text-right').append($link)
    $('#modal').html($modal_html).modal()
    return false
