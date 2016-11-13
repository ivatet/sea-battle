class CreateAll < ActiveRecord::Migration
  def change
    create_table :fleet_configurations do |t|
      t.belongs_to :battle_configuration

      t.integer :ship_length
      t.integer :ship_cnt
    end

    create_table :battle_configurations do |t|
      t.string :configuration_name
      t.integer :width
      t.integer :height
    end

    create_table :battles do |t|
      t.belongs_to :battle_configuration

      t.string :battle_name
      t.string :creator_uuid

      # who next turn belongs to
      t.string :next_uuid

      # an optimisation which saves CPU on AJAX polling
      t.integer :turn_number, :default => 0

      t.timestamps null: false
    end

    create_table :fleets do |t|
      t.belongs_to :battle

      t.string :fleet_name
      t.string :player_uuid

      # the game creator should choose one among the possible candidates
      t.boolean :is_approved, :default => false

      # a JSON string which is not supposed to be changed once arranged
      t.string :fleet_arrangement

      # a player's "shot map"
      t.string :shot_map

      # an optimisation which saves CPU on game routing
      t.integer :ship_cnt, :default => 10

      t.timestamps null: false
    end
  end
end
