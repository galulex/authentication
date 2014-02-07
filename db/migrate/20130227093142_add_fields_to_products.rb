class AddFieldsToProducts < ActiveRecord::Migration
  def change
    [:products, :product_drafts].each do |table|
      add_column table, :platform, :string, default: :android
      add_column table, :phone_form_factor, :boolean, default: false
      add_column table, :tablet_form_factor, :boolean, default: false
      add_column table, :single_pricing, :decimal, precision: 4, scale: 2
      add_column table, :pricing_type, :string, default: :single
    end
  end
end
