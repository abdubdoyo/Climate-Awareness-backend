class CreateCarbonFootprints < ActiveRecord::Migration[7.0]
  def change
    create_table :carbon_footprints do |t|
      t.integer :user_id
      t.integer :transport
      t.integer :energy
      t.integer :waste
      t.integer :total

      t.timestamps
    end
  end
end
