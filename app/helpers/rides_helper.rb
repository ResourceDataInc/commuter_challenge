module RidesHelper
  def trip_type(ride)
    I18n.t("ride.options.#{ride.type}")
  end

  def work_or_personal(work)
    if(work)
      I18n.t("ride.options.work_trip")
    else
      I18n.t("ride.options.personal_trip")
    end
  end
end
