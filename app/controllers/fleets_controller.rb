class FleetsController < ApplicationController
  before_filter :set_battle, :set_config

  def index
    # TODO fleet list with a "fight" button for creator
    # TODO fleet list for joiner AND a "join" button if not joined
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

    if @battle.fleets.any? { |f| f.owner_uuid == session[:player_uuid] }
      flash.now[:error] = "You already created a fleet!"
      render 'new' and return
    end

    unless @battle.creator_uuid == session[:player_uuid]
      unless verify_recaptcha(model: @fleet)
        flash.now[:error] = "Are you a human?"
        render 'new' and return
      end
    end

    @fleet.owner_uuid = session[:player_uuid]
    @fleet.is_approved = @battle.creator_uuid == @fleet.owner_uuid

    unless @fleet.save
      render 'new' and return
    end

    redirect_to battle_path(@battle)
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
