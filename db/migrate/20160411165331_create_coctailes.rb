class CreateCoctailes < ActiveRecord::Migration
  def change
    create_table :coctailes do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
