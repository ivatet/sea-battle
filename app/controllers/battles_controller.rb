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
  end

  def create
  end

  def show
  end

  def update
  end
end
