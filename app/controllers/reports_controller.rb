class ReportsController < EnterpriseController
  def technical_payment
  end

  def technical_clearance
    #render plain: @enterprise.technicals.find(params[:technical_id]).inspect
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

end
