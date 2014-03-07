module Calendar
  module_function

  def today
    Time.zone.now.to_date
  end

  def tomorrow
    today.tomorrow
  end
end
