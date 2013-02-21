class CreateProductReviews < ActiveRecord::Migration
  def change
    create_table :product_reviews do |t|
      t.references  :user
      t.references  :product
      t.string      :title
      t.text        :review

      t.timestamps
    end
    add_index :product_ratings, [:product_id, :user_id], unique: true
  end
end
