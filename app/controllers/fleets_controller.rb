class FleetsController < ApplicationController
  before_filter :set_battle, :set_config

  def index
  end

  def new
    names = ["Pain Killers",
             "Team Berserker",
             "The Ultimate Warrior",
             "Warrior Defense",
             "Dead Last",
             "Post-apocalyptic Society"]

    @fleet = @battle.fleets.new(:fleet_name => names.sample)
  end

  def create
    @fleet = @battle.fleets.new(fleet_params)

    unless @fleet.valid?
      render 'new' and return
    end

    # TODO allow one UUID per battle
    # TODO captcha for the joiners

    @fleet.owner_uuid = session[:player_uuid]
    @fleet.is_approved = @battle[:creator_uuid] == session[:player_uuid]

    unless @fleet.save
      render 'new' and return
    end

    redirect_to battle_fleets_path(@battle)
  end

private

  def fleet_params
    params.require(:fleet).permit(:fleet_name, :fleet_json)
  end

  def set_battle
    @battle = Battle.find(params[:battle_id])
  end

  def set_config
    battle_cfg = @battle.battle_configuration

    @w, @h = battle_cfg.map_width, battle_cfg.map_height
    @lengths = battle_cfg.flatten_ship_lengths
  end
end
