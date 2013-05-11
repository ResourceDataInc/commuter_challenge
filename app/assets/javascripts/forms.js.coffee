jQuery ->
  $("input.datepicker").datepicker
    format: "yyyy-mm-dd"
    autoclose: true

  maxHeight=0;
  $('.equal-height').each ->
    if($(this).height()>maxHeight)
        maxHeight=$(this).height()

  $('.equal-height').height(maxHeight);