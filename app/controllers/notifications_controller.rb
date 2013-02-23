class NotificationsController < ApplicationController

  add_breadcrumb I18n.t('breadcrumbs.marketplace'), :root_path

  def index
    @notifications = current_user.notifications.order('created_at DESC').to_a
    current_user.notifications.unread.update_all(read: true)
  end

  def destroy
    if params[:id] == 'all'
      current_user.notifications.delete_all
    else
      @notification = current_user.notifications.find(params[:id])
      @notification.delete
    end
    respond_to do |format|
      format.html { redirect_to notifications_path }
      format.js
    end
  end

end
