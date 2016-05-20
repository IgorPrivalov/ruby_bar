class AddColumnImageToCoctailes < ActiveRecord::Migration
  def change
    add_column :coctailes, :image, :string
  end
end
