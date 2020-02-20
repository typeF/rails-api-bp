class AddFieldsToShops < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :created_by, :string
  end
end
