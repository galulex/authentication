class CreateProductReviews < ActiveRecord::Migration
  def change
    create_table :product_reviews do |t|
      t.references  :user
      t.references  :product
      t.string      :title
      t.text        :review

      t.timestamps
    end
    add_index :product_reviews, :user_id
    add_index :product_reviews, :product_id
  end
end
