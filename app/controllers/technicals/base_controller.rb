module Technicals
  class BaseController < EnterpriseController
    before_action :load_client

    private

    def load_client
      @technical = @enterprise.technicals.find(technical_id)
    end

    def technical_id
      params.require(:technical_id)
    end
  end
end
