class Transactions::TechnicalsController < EnterpriseController
  def new
    @transaction = @enterprise.transactions.new(technical_attributes: {})
  end
end
