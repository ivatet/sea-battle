class BattlesController < ApplicationController
  def index
    @vacant_battles = Battle
      .joins("LEFT JOIN fleets ON battles.id = fleets.battle_id")
      .group("battles.id")
      .having("COUNT(CASE WHEN fleets.is_approved = ? THEN 1 END) < 2", true)

    @ongoing_battles = []
  end

  def new
    names = ["Battle Of The Eternal Day",
             "Attack Of Frozen Fires",
             "War Of Eternal Suffering",
             "Assault Of The True King",
             "Siege Of New Hope",
             "War Of Blind Justice",
             "Siege Of The Apocalypse",
             "Assault Of The Last Stand"]

    @battle = Battle.new(:battle_name => names.sample,
                         :battle_configuration_id => BattleConfiguration.first.id)
  end

  def battle_params
    params.require(:battle).permit(:battle_name, :battle_configuration_id)
  end

  def create
    @battle = Battle.new(battle_params)
    if verify_recaptcha(model: @battle)
      @battle[:creator_uuid] = session[:player_uuid]
      @battle.save
      redirect_to @battle
    else
      flash.now[:error] = "Are you a human?"
      render 'new'
    end
  end

  def show
    redirect_to new_battle_fleet_path(params[:id])
  end

  def update
  end
end
