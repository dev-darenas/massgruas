class Transactions::AccountsController < EnterprisesController
  def new
    @transaction = @enterprise.transactions.new(account_attributes: {})
  end
end
