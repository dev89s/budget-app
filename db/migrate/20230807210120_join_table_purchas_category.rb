class JoinTablePurchasCategory < ActiveRecord::Migration[7.0]
  def change
    create_join_table :purchases, :categories do |t|
      t.index [:purchase_id, :category_id]
      # t.index [:category_id, :purchase_id]

      t.timestamps
    end
    add_foreign_key :categories_purchases, :purchases, column: :purchase_id
    add_foreign_key :categories_purchases, :categories, column: :category_id
  end
end
