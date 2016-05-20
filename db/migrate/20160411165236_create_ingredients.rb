class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.belongs_to :product
      t.belongs_to :coctaile
      t.float :value
      t.timestamps null: false
    end
  end
end
