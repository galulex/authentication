class CreateProductReviews < ActiveRecord::Migration
  def change
    create_table :product_reviews do |t|
      t.references  :user
      t.references  :product
      t.string      :title
      t.text        :review

      t.timestamps
    end
  end
end
