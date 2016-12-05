module BattleHelper
  def battle_cfg_descr(battle_cfg)
    total_ship_cnt = battle_cfg.fleet_configurations.map do |fleet_cfg|
      fleet_cfg.ship_cnt
    end.reduce(0, :+)

    map_width = battle_cfg.map_width
    map_height = battle_cfg.map_height

    "#{total_ship_cnt} battleships@#{map_width}x#{map_height}"
  end

  def battle_partial
    uuid = session[:player_uuid]
    is_ongoing = @battle.fleets.many? { |f| f.is_approved }
    if is_ongoing
      is_player = fleets.find { |f| f.owner_uuid == uuid and f.is_approved }
      if is_player then "ongoing_player" else "ongoing_guest" end
    else
      is_creator = @battle.creator_uuid == uuid
      if is_creator then "blank_creator" else "blank_joiner" end
    end
  end

  def fleet_created?
    uuid = session[:player_uuid]
    @battle.fleets.any? { |f| f.owner_uuid == uuid }
  end

  def joiner_approved?
    @battle.fleets.any? { |f| f.owner_uuid != @battle.creator_uuid and f.is_approved }
  end
end
