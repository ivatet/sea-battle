class FleetsController < ApplicationController
  def index
  end

  def new
    @battle = Battle.find(params[:battle_id])
    battle_cfg = @battle.battle_configuration

    @w, @h = battle_cfg.map_width, battle_cfg.map_height
    @lengths = battle_cfg.flatten_ship_lengths

    names = ["Pain Killers",
             "Team Berserker",
             "The Ultimate Warrior",
             "Warrior Defense",
             "Dead Last",
             "Post-apocalyptic Society"]

    is_approved = @battle[:creator_uuid] == session[:player_uuid]

    @fleet = @battle.fleets.new(:fleet_name => names.sample,
                                :owner_uuid => session[:player_uuid],
                                :is_approved => is_approved)
  end

  def create
  end

  def show
  end
end
