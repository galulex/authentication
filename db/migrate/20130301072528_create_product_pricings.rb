class CreateProductPricings < ActiveRecord::Migration
  def change
    create_table :product_pricings do |t|
      t.references  :pricingable, polymorphic: true
      t.integer     :from
      t.integer     :to
      t.decimal     :price, precision: 4, scale: 2

      t.timestamps
    end
    add_index :product_pricings, :pricingable_id
  end
end
