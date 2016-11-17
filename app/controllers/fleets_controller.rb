class FleetsController < ApplicationController
  def index
  end

  def ship_lengths(battle_cfg)
    battle_cfg.fleet_configurations.collect do |fleet_cfg|
      Array.new(fleet_cfg.ship_cnt, fleet_cfg.ship_length)
    end.flatten
  end

  def new
    battle = Battle.find(params[:battle_id])
    battle_cfg = battle.battle_configuration
    @w, @h = battle_cfg.map_width, battle_cfg.map_height
    @lengths = ship_lengths(battle_cfg)
  end

  def create
  end

  def show
  end
end
