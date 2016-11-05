class BattlesController < ApplicationController
  def index
    @vacant_battles = Battle
      .select("battles.id, battles.battle_name")
      .joins("LEFT JOIN teams ON battles.id = teams.battle_id")
      .group("battles.id")
      .having("COUNT(CASE WHEN teams.is_approved = ? THEN 1 END) < 2", true)

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

    @battle = Battle.new(:battle_name => names.sample)
  end

  def battle_params
    params.require(:battle).permit(:battle_name)
  end

  def create
    @battle = Battle.new(battle_params)
    if verify_recaptcha(model: @battle)
      @battle.save
      redirect_to @battle
    else
      flash.now[:error] = "Are you a human?"
      render 'new'
    end
  end

  def show
  end

  def update
  end
end
