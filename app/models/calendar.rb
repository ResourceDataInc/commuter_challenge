module Calendar
  module_function

  def today
    @today ||= Time.zone.now.to_date
  end

  def tomorrow
    @tomorrow ||= today.tomorrow
  end
end
