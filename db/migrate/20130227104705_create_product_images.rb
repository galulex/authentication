class CreateProductImages < ActiveRecord::Migration
  def change
    create_table :product_images do |t|
      t.references :imageable, polymorphic: true
      t.string :file

      t.timestamps
    end
    add_index :product_images, :imageable_id
  end
end
