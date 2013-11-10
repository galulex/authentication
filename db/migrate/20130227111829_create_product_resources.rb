class CreateProductResources < ActiveRecord::Migration
  def change
    create_table :product_resources do |t|
      t.references :resourceable, polymorphic: true
      t.string :title
      t.string :file

      t.timestamps
    end
    add_index :product_resources, :resourceable_id
  end
end
