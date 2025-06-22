class AddFieldsToVehicles < ActiveRecord::Migration[8.0]
  def change
    add_column :vehicles, :price_per_day, :integer
    add_column :vehicles, :location, :string
    add_column :vehicles, :available_from, :date
    add_column :vehicles, :available_to, :date
    add_reference :vehicles, :user, null: false, foreign_key: true
  end
end
