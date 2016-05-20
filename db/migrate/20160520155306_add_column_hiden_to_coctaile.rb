class AddColumnHidenToCoctaile < ActiveRecord::Migration
  def change
    add_column :coctailes, :hiden, :boolean, default: 0
  end
end
