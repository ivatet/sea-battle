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

      t.string :battle_name, :null => false
      t.string :creator_uuid, :null => false
      t.string :attacker_uuid

      t.timestamps
    end

    create_table :fleets do |t|
      t.belongs_to :battle

      t.string :fleet_name, :null => false
      t.string :owner_uuid, :null => false
      t.boolean :is_approved, :default => false

      t.string :fleet_json, :null => false
      t.string :shot_map_json, :default => "[]"

      t.timestamps
    end
  end
end
