# Arrange player's fleet on a two-dimensional map

random = (n) -> Math.floor(Math.random() * n)


class Canvas
  constructor: (@w, @h) ->
    @data = (false for [0 .. @w * @h - 1])

  draw: (shape) ->
    @data[p.y * @w + p.x] = true for p in shape.points

  visit: (visitor) ->
    visitor(i, @data[i]) for i in [0 .. @w * @h - 1]


class Point
  constructor: (@x, @y) ->

  sum: (p) ->
    new Point(@x + p.x, @y + p.y)

  mul: (k) ->
    new Point(@x * k, @y * k)


class PointGenerator
  constructor: (w, h) ->
    @points = []
    for y in [0 .. h - 1]
      for x in [0 .. w - 1]
        @points.push new Point(x, y)

  next: ->
    i = random(@points.length)
    p = @points[p]
    @points.splice(i)
    p


class Bar
  constructor: (p1, p2) ->
    @points = []
    for y in [p1.y .. p2.y]
      for x in [p1.x .. p2.x]
        @points.push new Point(x, y)


class Position
  constructor: (@value) ->

  iterator: ->
    switch @value
      when "h" then new Point(1, 0)
      when "v" then new Point(0, 1)


class PositionGenerator
  next: ->
    new Position ["v", "h"][random(2)]


class Ship
  constructor: (@point, @len, @pos) ->

  head: ->
    @point

  tail: ->
    @point.sum(@pos.iterator().mul(@len - 1))

  shape: ->
    new Bar(@head(), @tail())


class Shipwreck
  constructor: (@ship) ->

  shape: ->
    new Bar(@ship.head().sum(new Point(-1, -1)),
            @ship.tail().sum(new Point( 1,  1)))


class Fleet
  constructor: ->
    @ships = []

  add: (ship) ->
    @ships.push ship


class FleetGenerator
  constructor: (@w, @h, @lengths) ->

  # FixMe
  next: =>
    fleet = new Fleet
    fleet.add new Ship(new Point(3, 4), 2, new Position("v"))
    fleet


class FleetRenderer
  constructor: (@w, @h) ->

  html: (i, v) =>
    $("#grid-#{i}").html(if v then "<b>o</b>" else "_")

  render: (fleet) =>
    canvas = new Canvas(@w, @h)
    canvas.draw(ship.shape()) for ship in fleet.ships
    canvas.visit(@html)
    fleet


compose = (f, g) ->
  ->
    g(f())


$ ->
  generate = compose(
    compose(new FleetGenerator(window.App.w,
                               window.App.h,
                               window.App.lengths).next,
            new FleetRenderer(window.App.w,
                              window.App.h).render),
    (fleet) -> window.App.fleet = fleet)

  window.App.fleet = generate()
  window.App.generate = generate
