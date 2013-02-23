class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references  :user
      t.string      :notification_type
      t.text        :data
      t.column      :read, :boolean, default: false

      t.timestamps
    end
    add_index :notifications, :user_id
  end
end
