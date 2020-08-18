class ReportsController < EnterpriseController
  def technical_payment
  end

  def payment_per_vehicle
  end

  def transaction_report
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

  def service_report
    params[:client_ids].each_with_index do |c, index|
      if c.blank?
        params[:client_ids].delete_at(index)
      end
    end

    params[:service_ids].each_with_index do |c, index|
      if c.blank?
        params[:service_ids].delete_at(index)
      end
    end

    @transactions = @enterprise.transactions
    @transactions = @transactions.where(fecha: params[:initial_date]..params[:final_date])
    @transactions = @transactions.where(client_id: params[:client_ids]) unless params[:client_ids].blank?
    @transactions = @transactions.where(service_id: params[:service_ids]) unless params[:service_ids].blank?
    @totalg = 0.0
    @totalt = 0.0
  end

end
