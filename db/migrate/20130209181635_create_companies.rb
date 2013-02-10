class CreateCompanies < ActiveRecord::Migration
  def change
    [:companies, :company_drafts].each do |table|
      create_table table do |t|
        t.references  :company if table == :company_drafts
        t.string      :name
        t.attachment  :logo
        t.text        :synopsis
        t.text        :description
        t.integer     :employee_limit, default: 20
        t.string      :status

        t.timestamps
      end
    end
  end
end
