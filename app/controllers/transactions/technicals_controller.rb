class Transactions::TechnicalsController < EnterprisesController
  def new
    @transaction = @enterprise.transactions.new(technical_attributes: {})
  end
end
