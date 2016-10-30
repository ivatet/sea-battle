class Battle < ActiveRecord::Base
  has_many :teams
  belongs_to :team
end
