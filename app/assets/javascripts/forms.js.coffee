jQuery ->
  $("input.datepicker").each ->
    $(this).datepicker
      endDate: $(this).data("end-date")
      format: "yyyy-mm-dd"
      autoclose: true

  $("form .btn-group").each ->
    field = $("##{$(this).data("field")}")
    $(this).find("button").click ->
      field.val($(this).val())

  maxHeight=0
  $('.equal-height').each ->
    if($(this).height()>maxHeight)
        maxHeight=$(this).height()

  $('.equal-height').height(maxHeight)
