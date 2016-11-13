class CreateAll < ActiveRecord::Migration
  def change
    create_table :battles do |t|
      # just a name given by the game creator
      t.string :battle_name

      # the game creator which will be approved by default
      t.string :creator_uuid

      # who the next turn belongs to
      t.belongs_to :fleet

      # an optimisation which saves CPU on AJAX polling
      t.integer :turn_number, :default => 0

      t.timestamps null: false
    end

    create_table :fleets do |t|
      # a fleet is assigned to only one game
      t.belongs_to :battle

      # player UUID is originally stored in cookies
      t.string :player_uuid

      # the game creator should choose one among the possible candidates
      t.boolean :is_approved, :default => false

      # a JSON string which is not supposed to be changed once arranged
      t.string :boat_arrangement

      # a player's "shot map"
      t.string :opponent_field

      # an optimisation which saves CPU on game routing
      t.integer :boat_cnt, :default => 10

      t.timestamps null: false
    end
  end
end
