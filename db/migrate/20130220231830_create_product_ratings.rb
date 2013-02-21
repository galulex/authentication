class CreateProductRatings < ActiveRecord::Migration
  def change
    create_table :product_ratings do |t|
      t.references :product
      t.references :user
      t.integer :score

      t.timestamps
    end
    add_index :product_ratings, [:product_id, :user_id], unique: true
  end
end
