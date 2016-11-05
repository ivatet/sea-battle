random = (N) ->
  Math.floor(Math.random() * N)

class Point
  constructor: (x, y) ->
    [@x, @y] = [x, y]

  inc: (coordinate) ->
    if coordinate < 10 then coordinate + 1 else coordinate

  dec: (coordinate) ->
    if coordinate > 0 then coordinate - 1 else coordinate

  topleft: ->
    new Point(@dec(@x), @dec(@y))

  bottomright: ->
    new Point(@inc(@x), @inc(@y))

class Boat
  constructor: (x, y, len, pos) ->
    [@x, @y, @len, @pos] = [x, y, len, pos]

  points: ->
    d = new Point((if @pos is "h" then 1 else 0),
                  (if @pos is "v" then 1 else 0))

    (new Point(@x + i * d.x,
               @y + i * d.y) for i in [0..(@len - 1)])

class Raster
  constructor: ->
    @raster = (false for [0..99])

  draw: (boat) ->
    for p in boat.points()
      @raster[p.y * 10 + p.x] = true

  value: (x, y) ->
    @raster[y * 10 + x]

class Team
  constructor: ->
    @boats = []

  add: (boat) ->
    @boats.push(boat)

  raster: ->
    r = new Raster
    for boat in @boats
      r.draw(boat)
    return r

class TeamCreator
  is_collide: (boat, raster) ->
    [first, ..., last] = boat.points()
    for y in [first.topleft().y..last.bottomright().y]
      for x in [first.topleft().x..last.bottomright().x]
        return true if raster.value(x, y)

    return false

  create: ->
    team = new Team

    for len in [4, 3, 3, 2, 2, 2, 1, 1, 1, 1]
      raster = team.raster()
      pos = ["v", "h"][random(2)]
      options = []
      for y in [0..10 - len]
        for x in [0..10 - len]
          boat = new Boat(x, y, len, pos)

          if not @is_collide(boat, raster)
            options.push(boat)

      team.add(options[random(options.length)])

    return team

create_team = () ->
  window.App.team = (new TeamCreator).create()

render_team = () ->
  raster = window.App.team.raster()
  for i in [0..99]
    $("#grid-#{i}").html(if raster.raster[i] then "<b>o</b>" else "_")

arrange_team = () ->
  create_team()
  render_team()

main = () ->
  window.App =
    team: []
    arrange_team: arrange_team

$(document).on('turbolinks:load', main);
