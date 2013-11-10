class CreateProductCategories < ActiveRecord::Migration
  def change
    create_table :product_categories do |t|
      t.references :categorizable, polymorphic: true
      t.references :category

      t.timestamps
    end
    add_index :product_categories, [:categorizable_id, :category_id], unique: true
  end
end
