class CreateVehicles < ActiveRecord::Migration[8.0]
  def change
    create_table :vehicles do |t|
      t.string :title
      t.text :description
      t.string :vehicle_type
      t.string :engine_size

      t.timestamps
    end
  end
end
