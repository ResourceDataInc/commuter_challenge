jQuery ->
  $("input.datepicker").each ->
    $(this).datepicker
      endDate: $(this).data("end-date")
      format: "yyyy-mm-dd"
      autoclose: true

  maxHeight=0;
  $('.equal-height').each ->
    if($(this).height()>maxHeight)
        maxHeight=$(this).height()

  $('.equal-height').height(maxHeight);
