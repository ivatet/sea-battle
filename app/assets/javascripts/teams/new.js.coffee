# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

boat_body = (boat) ->
  r = []
  d =
    x: if boat.orient is "h" then 1 else 0
    y: if boat.orient is "v" then 1 else 0

  for i in [1..boat.length]
    p =
      x: boat.x + (i - 1) * d.x
      y: boat.y + (i - 1) * d.y

    r.push(p)

  return r

render_boats = (boats) ->
  for i in [0..99]
    $("#arrange-grid-#{i}").css("background-color", "White")

  for boat in boats
    for p in boat_body(boat)
      $("#arrange-grid-#{p.y * 10 + p.x}").css("background-color", "ForestGreen")

  return

random = (N) ->
  Math.floor(Math.random() * N)

fit = (boat, boats) ->
  raster = (0 for [0..99])
  for b in boats
    for p in boat_body(b)
      raster[p.y * 10 + p.x] = 1

  for p in boat_body(boat)
    return false if not do () ->
      for y in [-1..1]
        for x in [-1..1]
          return false if not do () ->
            return true if (p.x + x) < 0 or (p.x + x) > 9
            return true if (p.y + y) < 0 or (p.y + y) > 9
            return false if raster[(p.y + y) * 10 + (p.x + x)]
            return true

      return true

  return true

arrange_boats = () ->
  boats = []

  for length in [4, 3, 3, 2, 2, 2, 1, 1, 1, 1]
    orient = ["v", "h"][random(2)]

    options = []
    for y in [0..(10 - length)]
      for x in [0..(10 - length)]
        boat =
          x: x
          y: y
          length: length
          orient: orient

        if fit(boat, boats)
          options.push(boat)

    boats.push(options[random(options.length)])

  render_boats(boats)
  return boats

arrange_boats_ui = () ->
  window.App.boats = arrange_boats()
  $("#team").val(JSON.stringify(window.App.boats))
  $("#create-button").prop("disabled", not validate_boats(window.App.boats))
  return

validate_boats = (boats) ->
  # check the boat count
  return false if boats.length != 10

  # check boat lengths
  lengths = (0 for [0..3])
  for b in boats
    return false if b.length < 1 or b.length > 4
    lengths[b.length - 1] = lengths[b.length - 1] + 1

  return false if lengths[4] is not 1 or lengths[3] is not 2 or lengths[2] is not 3 or lengths[1] is not 4

  # check boat arrangement
  copy = []
  for b in boats
    if fit(b, copy) then copy.push(b) else return false

  return true

main = () ->
  window.App =
    boats: []
    arrange_boats_ui: arrange_boats_ui

$(document).on('turbolinks:load', main);
