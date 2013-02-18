class CreateProducts < ActiveRecord::Migration
  def change
    [:products, :product_drafts].each do |table|
      create_table table do |t|
        t.references  :company
        t.references  :product if table == :product_drafts
        t.attachment  :software
        t.attachment  :icon
        t.attachment  :image
        t.attachment  :banner
        t.string      :slug
        t.string      :name
        t.string      :version
        t.text        :summary
        t.text        :description
        t.text        :features
        t.text        :support
        t.string      :status, default: 'draft'
        t.boolean     :featured

        t.timestamps
      end
    end
    add_index :products, :slug, unique: true
    add_index :product_drafts, :slug, unique: true
    add_index :products, :company_id
    add_index :product_drafts, :product_id
  end
end
