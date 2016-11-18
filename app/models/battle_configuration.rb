class BattleConfiguration < ActiveRecord::Base
  has_many :fleet_configurations
  has_many :battles

  def flatten_ship_lengths
    fleet_configurations.collect do |fleet_cfg|
      Array.new(fleet_cfg.ship_cnt, fleet_cfg.ship_length)
    end.flatten
  end
end
