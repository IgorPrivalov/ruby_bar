class AddColumnValueToCoctailes < ActiveRecord::Migration
  def change
    add_column :coctailes, :value, :float
  end
end
