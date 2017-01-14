module SeaBattle
  class FleetConfig
    def initialize(owner_uuid, fleet_json, shot_map_json)
      @owner_uuid = owner_uuid
      @fleet_json = fleet_json
      @shot_map_json = shot_map_json
    end
  end
end
