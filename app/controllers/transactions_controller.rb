class TransactionsController < EnterpriseController
  def index
    case params[:status]
    when 'open'
      @transactions = @enterprise.transactions.s_opened
    when 'delivered'
      @transactions = @enterprise.transactions.s_delivered
    when 'closed'
      @transactions = @enterprise.transactions.s_delivered
    else
      @transactions = @enterprise.transactions
    end
  end

  def show
  end

  def new
    @transaction = @enterprise.transactions.new(status: 'open')

  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end
