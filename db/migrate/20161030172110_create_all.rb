class CreateAll < ActiveRecord::Migration
  def change
    create_table :fleet_configurations do |t|
      t.belongs_to :battle_configuration

      t.integer :ship_length
      t.integer :ship_cnt
    end

    create_table :battle_configurations do |t|
      t.string :configuration_name
      t.integer :map_width
      t.integer :map_height
    end

    create_table :battles do |t|
      t.belongs_to :battle_configuration

      t.string :battle_name
      t.string :creator_uuid
      t.string :attacker_uuid

      t.timestamps
    end

    create_table :fleets do |t|
      t.belongs_to :battle

      t.string :fleet_name
      t.string :owner_uuid
      t.boolean :is_approved

      t.string :fleet_json
      t.string :shot_map_json

      t.timestamps
    end
  end
end
