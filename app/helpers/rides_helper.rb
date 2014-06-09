module RidesHelper
  def trip_type(ride)
    I18n.t("ride.options.#{ride.type}")
  end
end
