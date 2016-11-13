class BattleConfiguration < ActiveRecord::Base
  has_many :fleet_configurations
  has_many :battles
end
