# Arrange player's fleet on a two-dimensional map

random = (n) -> Math.floor(Math.random() * n)


class Canvas
  constructor: (@w, @h) ->
    @data = (false for [0 .. @w * @h - 1])

  drawPoint: (p) ->
    @data[p.y * @w + p.x] = true

  drawShape: (shape) ->
    @drawPoint p for p in shape.points

  pointFits: (p) ->
    p.x >= 0 and p.x < @w and p.y >= 0 and p.y < @h

  shapeFits: (shape) ->
    not (p for p in shape.points when not @pointFits p).length

  mapShape: (shape) ->
    new Shape (p for p in shape.points when @pointFits p)

  shapeCollides: (shape) ->
    (p for p in shape.points when @data[p.y * @w + p.x]).length

  visit: (visitor) ->
    visitor i, @data[i] for i in [0 .. @w * @h - 1]


class Point
  constructor: (@x, @y) ->

  sum: (p) ->
    new Point @x + p.x, @y + p.y

  mul: (k) ->
    new Point @x * k, @y * k


class PointGenerator
  constructor: (w, h) ->
    @points = []
    for y in [0 .. h - 1]
      for x in [0 .. w - 1]
        @points.push new Point x, y

  next: ->
    i = random @points.length
    p = @points[i]
    @points.splice i, 1
    p


class Shape
  constructor: (@points) ->


class Bar extends Shape
  constructor: (p1, p2) ->
    super []
    for y in [p1.y .. p2.y]
      for x in [p1.x .. p2.x]
        @points.push new Point x, y


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
    new Bar @head(), @tail()


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

  next: =>
    fleet = new Fleet
    canvas = new Canvas @w, @h
    posGen = new PositionGenerator

    for len in @lengths
      ptGen = new PointGenerator @w, @h

      while pt = ptGen.next()
        ship = new Ship pt, len, posGen.next()

        continue if not canvas.shapeFits ship.shape()

        continue if canvas.shapeCollides(
                      canvas.mapShape(
                        new Shipwreck(ship).shape()))

        fleet.add ship
        canvas.drawShape ship.shape()

        break

    fleet


class FleetRenderer
  constructor: (@w, @h) ->

  html: (i, v) =>
    $("#grid-#{i}").html(if v then "<b>o</b>" else "_")

  render: (fleet) =>
    canvas = new Canvas @w, @h
    canvas.drawShape ship.shape() for ship in fleet.ships
    canvas.visit @html
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
    (fleet) ->
      $("#fleet_json").val(JSON.stringify(fleet))
  )

  generate()

  $("#fleet-generate-btn").click ->
    generate()
    false
