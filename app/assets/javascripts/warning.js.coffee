jQuery ->
  warned = $.cookie("warned")
  if(!warned)
    $("#ie-warning").modal()

  $("#ie-warning .btn-primary").click ->
    $.cookie("warned", "true")
    $("#ie-warning").modal("hide")