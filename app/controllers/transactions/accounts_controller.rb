class Transactions::AccountsController < EnterpriseController
  def new
    @transaction = @enterprise.transactions.new(account_attributes: {})
  end
end
