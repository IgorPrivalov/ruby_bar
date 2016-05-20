class AddColumnAlcToProducts < ActiveRecord::Migration
  def change
    add_column :products, :have_alc, :integer
  end
end
