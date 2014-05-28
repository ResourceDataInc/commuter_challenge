jQuery ->
  form = $("form.new_ride,form.edit_ride")

  disableFields = ->
    $("#ride_bike_distance").prop("disabled", true)
    $("#ride_bus_distance").prop("disabled", true)
    $("#ride_walk_distance").prop("disabled", true)

  if $("#type > button[value=vacation]", form).hasClass("active")
    disableFields()

  $("#type > button[value=vacation]", form).click ->
    disableFields()

  $("#type > button[value!=vacation]", form).click ->
    $("#ride_bike_distance").prop("disabled", false)
    $("#ride_bus_distance").prop("disabled", false)
    $("#ride_walk_distance").prop("disabled", false)
