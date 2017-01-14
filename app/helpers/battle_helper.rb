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
    if @battle.ongoing?
      if @battle.approved_fleets.find { |f| f.owner_uuid == session[:player_uuid] }
        then "ongoing_player" else "ongoing_guest" end
    else
      if @battle.creator_uuid == session[:player_uuid]
        then "blank_creator" else "blank_joiner" end
    end
  end

  def link_to_create_fleet_partial
    if @battle.fleets.any? { |f| f.owner_uuid == session[:player_uuid] }
      then "label_complete" else "link_to_create_fleet" end
  end

  def link_to_approve_joiner_partial
    if @battle.joiner_approved? then "label_complete" else "link_to_approve_joiner" end
  end
end
