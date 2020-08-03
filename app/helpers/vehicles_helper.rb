module VehiclesHelper

  def days_soat(vehicle)
    unless vehicle.vencimiento_soat.blank?
      ((Date.parse vehicle.vencimiento_soat.to_s) - (Date.parse Time.now.to_s)).to_i
    else
      6
    end
  end

  def days_rtm (vehicle)
    unless vehicle.vencimiento_rtm.blank?
      ((Date.parse vehicle.vencimiento_rtm.to_s) - (Date.parse Time.now.to_s)).to_i
    else
      6
    end
  end

  def days_next_oil_change_date(vehicle)
    unless vehicle.next_oil_change_date.blank?
      ((Date.parse vehicle.next_oil_change_date.to_s) - (Date.parse Time.now.to_s)).to_i
    else
      6
    end
  end

  def text_warning_soat(vehicle)
    "text-warning" if days_soat(vehicle) >= 1 && days_soat(vehicle) <= 5
  end

  def text_warning_rtm(vehicle)
    "text-warning" if days_rtm(vehicle) >= 1 && days_rtm(vehicle) <= 5
  end

  def tr_warning_o_danger(vehicle)
    if days_soat_rtm_zero(vehicle)
      "table-danger"
    elsif  days_soat_five(vehicle) || days_rtm_five(vehicle)
      return "table-warning"
    else
      ""
    end
  end

  def days_soat_zero(vehicle)
    days_soat(vehicle) <= 0
  end

  def days_rtm_zero(vehicle)
    days_rtm(vehicle) <= 0
  end

  def days_next_oil_change_date_zero(vehicle)
    days_next_oil_change_date(vehicle) <= 0
  end

  def days_soat_rtm_zero(vehicle)
    days_soat_zero(vehicle) || days_rtm_zero(vehicle)
  end

  def days_soat_five(vehicle)
    (days_soat(vehicle) >= 1 && days_soat(vehicle) <= 5)
  end

  def days_next_oil_change_date_five(vehicle)
    days_next_oil_change_date(vehicle) >= 1 && days_next_oil_change_date(vehicle) <=5
  end

  def days_rtm_five(vehicle)
    (days_rtm(vehicle) >= 1 && days_rtm(vehicle) <= 5)
  end

end
