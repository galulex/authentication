class Notification < ActiveRecord::Base
  belongs_to :user
  attr_accessible :notification_type, :data
  serialize :data, Hash

  def message
    I18n.t("notifications.#{notification_type}", data)
  end

end
