module Vehicles
  class BaseController < EnterprisesController
    before_action :load_vehicle

    private

    def load_vehicle
      @vehicle = @enterprise.vehicles.find(vehicle_id)
    end

    def vehicle_id
      params.require(:vehicle_id)
    end
  end
end
