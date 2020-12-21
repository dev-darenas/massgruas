class ReportsController < EnterprisesController
  def technical_payment
  end

  def payment_per_vehicle
  end

  def transaction_report
  end

  def technical_clearance
    @technical = @enterprise.technicals.find(params[:technical_id])
    @total = 0.0

    initial_date = params[:initial_date].to_date.beginning_of_day
    final_date = params[:final_date].to_date.end_of_day
    @transactions = @technical.transactions.where(fecha: initial_date..final_date).order(fecha: :asc)

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
    @total = 0.0

    initial_date = params[:initial_date].to_date.beginning_of_day
    final_date = params[:final_date].to_date.end_of_day
    @transactions = @vehicle.transactions.where(fecha: initial_date..final_date).order(fecha: :asc)

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
    unless params[:client_ids].nil?
      params[:client_ids].each_with_index do |c, index|
        if c.blank?
          params[:client_ids].delete_at(index)
        end
      end
    end

    unless params[:service_ids].nil?
      params[:service_ids].each_with_index do |c, index|
        if c.blank?
          params[:service_ids].delete_at(index)
        end
      end
    end

    unless params[:account_ids].nil?
      params[:account_ids].each_with_index do |c, index|
        if c.blank?
          params[:account_ids].delete_at(index)
        end
      end
    end

    unless params[:vehcle_ids].nil?
      params[:vehcle_ids].each_with_index do |c, index|
        if c.blank?
          params[:vehcle_ids].delete_at(index)
        end
      end
    end
    params[:initial_date] ||= Date.today.beginning_of_month.strftime("%Y-%m-%d")
    params[:final_date] ||= Date.today.end_of_month.strftime("%Y-%m-%d")

    @transactions = @enterprise.transactions
    @transactions = @transactions.where(fecha: params[:initial_date]..params[:final_date])
    @transactions = @transactions.where(client_id: params[:client_ids]) unless params[:client_ids].blank?
    @transactions = @transactions.where(account_id: params[:account_ids]) unless params[:account_ids].blank?
    @transactions = @transactions.where(service_id: params[:service_ids]) unless params[:service_ids].blank?
    @transactions = @transactions.where(vehicle_id: params[:vehcle_ids]) unless params[:vehcle_ids].blank?
    @transactions = @transactions.where("horas_de_espera >= ?", params[:wait_time]) if params[:wait_time].to_i > 0

    @totalg = 0.0
    @totalt = 0.0

    respond_to do |format|
      format.html
      format.js
      format.pdf do
        render layout: 'pdf',
               pdf: "Reporte_Transacción",
               template: "reports/_service_report.html.slim",
               title: 'Reporte Transacción',
               encoding: 'UTF-8'
      end
      format.xlsx do
        response.headers['Content-Disposition'] = 'attachment; filename="Reporte_transacción.xlsx"'
      end
    end
  end

end
