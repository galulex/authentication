class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :employee_limit, default: 20

      t.timestamps
    end
  end
end
