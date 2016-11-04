class BattlesController < ApplicationController
  def index
    @vacant_battles = Battle
      .select("battles.id,
               battles.battle_name,
               COUNT(CASE WHEN teams.is_approved = 't' THEN 1 ELSE NULL END) AS cnt")
      .joins(:teams)
      .group("battles.id")
      .having("cnt < 2")

    @ongoing_battles = []
  end

  def new
  end

  def create
  end

  def show
  end

  def update
  end
end
