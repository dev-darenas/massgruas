class Transactions::VehiclesController < EnterprisesController
  def new
    @transaction = @enterprise.transactions.new(vehicle_attributes: {})
  end
end
