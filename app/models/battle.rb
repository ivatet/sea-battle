class Battle < ActiveRecord::Base
  belongs_to :battle_configuration
  has_many :fleets
  validates :battle_name, presence: true, length: {
    minimum: 2,
    maximum: 40,
    too_short: "%{count} characters is the minimum allowed",
    too_long: "%{count} characters is the maximum allowed"
  }

  def self.blank_games
    self
      .joins("LEFT JOIN fleets ON battles.id = fleets.battle_id")
      .group("battles.id")
      .having("COUNT(CASE WHEN fleets.is_approved = ? THEN 1 END) < 2", true)
  end
end
