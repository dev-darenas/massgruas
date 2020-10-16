class EnterprisesController < ApplicationController
  before_action :load_enterprise

  def load_enterprise
    @enterprise = current_user&.enterprise
  end
end
