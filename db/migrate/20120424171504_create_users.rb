class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references  :company
      t.references  :role
      t.string      :type
      t.boolean     :invited
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
      t.datetime    :deleted_at

      t.timestamps
    end
    add_index :users, :company_id
    add_index :users, :role_id
  end
end
