class Battle < ActiveRecord::Base
  belongs_to :battle_configuration
  has_many :fleets
  validates :battle_name, presence: true, length: {
    minimum: 2,
    maximum: 40,
    too_short: "%{count} characters is the minimum allowed",
    too_long: "%{count} characters is the maximum allowed"
  }
end
