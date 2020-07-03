class Transactions::ClientsController < EnterpriseController
  def new
    @transaction = @enterprise.transactions.new(client_attributes: {})
  end
end
