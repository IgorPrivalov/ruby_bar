class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.float :cost_price
      t.float :min_value
      t.string :product_type
      t.timestamps null: false
    end
  end
end
