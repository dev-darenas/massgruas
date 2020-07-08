class Transactions::VehiclesController < EnterpriseController
  def new
    @transaction = @enterprise.transactions.new(vehicle_attributes: {})
  end
end
