class ReportsController < EnterpriseController
  def technical_payment
  end

  def technical_clearance
    #render plain: @enterprise.technicals.find(params[:technical_id]).inspect
    @technical = @enterprise.technicals.find(params[:technical_id])
  end

end
