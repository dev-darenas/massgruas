module Clients
  class ListPricesController < BaseController
    before_action :set_list_price, only: [:show, :edit, :update, :destroy]

    def index
      @pagy, @list_prices = pagy( @client.list_prices)
    end

    def new
      @list_price = @client.list_prices.new
    end

    def create
      @list_price = @client.list_prices.new(list_price_params)
      if @list_price.save
        redirect_to edit_client_list_price_path(@client, @list_price),  notice: 'List price was successfully created.'
      else
        render :new
      end
    end

    def update
      if @list_price.update(list_price_params)
        redirect_to edit_client_list_price_path(@client, @list_price),  notice: 'List price was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @list_price.destroy
      redirect_to client_list_prices_path, notice: 'List_price was deleted'
    end

    private

    def set_list_price
      @list_price = @client.list_prices.find(params[:id])
    end

    def list_price_params
      params.require(:list_price).permit(:service_id, :flag, :waiting_hours_value, :kilometer_value,
                                         :night_surcharge, :red_zone_value, :holiday_surcharge)
    end
  end
end
