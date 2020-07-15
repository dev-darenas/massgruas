module Technicals
  class BondingDatesController < BaseController
    before_action :set_bonding_date, only: [:show, :edit, :update, :destroy]

    def index
      @bonding_dates = @technical.bonding_dates.all
    end

    def show
    end

    def new
      @bonding_date = @technical.bonding_dates.new
    end

    def edit
    end

    def create
      @bonding_date = @technical.bonding_dates.new(bonding_date_params)
      if @bonding_date.save
        redirect_to edit_technical_bonding_date_path(@technical, @bonding_date), notice: 'Bonding date was successfully created.'
      else
        render :new
      end
    end

    def update
      if @bonding_date.update(bonding_date_params)
        redirect_to edit_technical_bonding_date_path(@technical, @bonding_date), notice: 'Bonding date was successfully updated.'

      else
        render :edit
      end
    end

    def destroy
      if @bonding_date.destroy
        redirect_to technical_bonding_dates_path(@technical), notice: 'Bonding date was successfully destroyed.'
      end

    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_bonding_date
      @bonding_date = @technical.bonding_dates.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bonding_date_params
      params.require(:bonding_date).permit(:entry_date, :departure_date, :observation, :technical_id)
    end
  end
end
