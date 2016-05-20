class AddColunmAlcToCoctailes < ActiveRecord::Migration
  def change
    add_column :coctailes, :have_alc, :integer
  end
end
