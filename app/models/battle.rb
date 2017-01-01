class Battle < ActiveRecord::Base
  belongs_to :battle_configuration
  has_many :fleets
  validates :battle_name, presence: true, length: {
    minimum: 2,
    maximum: 40,
    too_short: "%{count} characters is the minimum allowed",
    too_long: "%{count} characters is the maximum allowed"
  }

  def joiner_approved?
    fleets.any? { |f| f.owner_uuid != creator_uuid and f.is_approved }
  end

  def ongoing?
    fleets.count { |f| f.is_approved } > 1
  end

  def approved_fleets
    fleets.find_all { |f| f.is_approved }
  end
end
