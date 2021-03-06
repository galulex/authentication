class CreateCompanies < ActiveRecord::Migration
  def change
    [:companies, :company_drafts].each do |table|
      create_table table do |t|
        t.references  :company if table == :company_drafts
        t.string      :slug
        t.string      :name
        t.string      :logo
        t.text        :synopsis
        t.text        :description
        t.integer     :employee_limit, default: 20
        t.string      :website
        t.string      :status, default: 'draft'
        t.string      :street1
        t.string      :street2
        t.string      :country
        t.string      :state
        t.string      :postal_code
        t.string      :city
        t.string      :phone
        t.boolean     :featured, default: false

        t.timestamps
      end
    end
    add_index :companies, :slug, unique: true
    add_index :company_drafts, :slug, unique: true
    add_index :company_drafts, :company_id
  end
end
