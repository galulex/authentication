class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references  :company
      t.references  :role
      t.string      :type
      t.string      :first_name
      t.string      :last_name
      t.string      :job
      t.string      :email
      t.string      :password_digest
      t.string      :token
      t.string      :auth_token
      t.string      :password_reset_token
      t.datetime    :password_reset_sent_at
      t.string      :new_email
      t.string      :new_email_token
      t.string      :deleted_at

      t.timestamps
    end
  end
end
