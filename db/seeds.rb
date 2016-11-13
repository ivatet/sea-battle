# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

config = BattleConfiguration.create(:configuration_name => "Classic",
                                    :width => 10, :height => 10)
config.fleet_configurations.create(:ship_length => 5, :ship_cnt => 1)
config.fleet_configurations.create(:ship_length => 4, :ship_cnt => 1)
config.fleet_configurations.create(:ship_length => 3, :ship_cnt => 2)
config.fleet_configurations.create(:ship_length => 2, :ship_cnt => 1)

config = BattleConfiguration.create(:configuration_name => "Russian",
                                    :width => 10, :height => 10)
config.fleet_configurations.create(:ship_length => 4, :ship_cnt => 1)
config.fleet_configurations.create(:ship_length => 3, :ship_cnt => 2)
config.fleet_configurations.create(:ship_length => 2, :ship_cnt => 3)
config.fleet_configurations.create(:ship_length => 1, :ship_cnt => 4)
