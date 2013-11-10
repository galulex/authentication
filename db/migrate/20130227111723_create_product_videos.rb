class CreateProductVideos < ActiveRecord::Migration
  def change
    create_table :product_videos do |t|
      t.references :videoable, polymorphic: true
      t.string :url

      t.timestamps
    end
    add_index :product_videos, :videoable_id
  end
end
