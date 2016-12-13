module FleetHelper
  def badge_partial(fleet)
    return "badge_you" if fleet.owner_uuid == session[:player_uuid]
    return "badge_approved" if fleet.owner_uuid != @battle.creator_uuid and fleet.is_approved
  end

  def is_fleet_created?
    @battle.fleets.any? { |f| f.owner_uuid == session[:player_uuid] }
  end

  def button_partial(fleet)
    return nil if @battle.approved_any?
    return nil unless @battle.creator_uuid == session[:player_uuid]
    return "button_approve" unless fleet.owner_uuid == @battle.creator_uuid
  end
end
