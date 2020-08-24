class Transactions::ClientsController < EnterprisesController
  def new
    @transaction = @enterprise.transactions.new(client_attributes: {})
  end
end
