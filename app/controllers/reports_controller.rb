class ReportsController < EnterpriseController
  def technical_payment
  end

  def payment_per_vehicle
  end

  def technical_clearance
    @technical = @enterprise.technicals.find(params[:technical_id])
    @total=0.0
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Liquidación Técnico",
               template: "reports/technical_clearance.html.slim",
               title: 'Liquidación Técnico',
               layout: 'pdf'
      end
    end
  end

  def vehicle_liquidation
    @vehicle = @enterprise.vehicles.find(params[:vehicle_id])
    @total=0.0

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Liquidación por Vehiculo",
               template: "reports/vehicle_liquidation.html.slim",
               title: 'Liquidación por Vehiculo',
               layout: 'pdf'
      end
    end
  end

end
