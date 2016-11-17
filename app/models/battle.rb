class Battle < ActiveRecord::Base
  belongs_to :battle_configuration
  has_many :fleets
end
