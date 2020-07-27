class VehiclesController < EnterpriseController
  before_action :set_vehicle, only: [:show, :edit, :update, :destroy]

  # GET /vehicles
  # GET /vehicles.json
  def index
    @pagy, @vehicles = pagy( @enterprise.vehicles)
  end

  # GET /vehicles/1
  # GET /vehicles/1.json
  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "vehicle",
               template: "vehicles/show.html.slim",
               layout: 'pdf'
      end
    end
  end

  # GET /vehicles/new
  def new
    @vehicle = @enterprise.vehicles.new
    @vehicle.pictures.build
  end

  # GET /vehicles/1/edit
  def edit
    @vehicle.pictures.build
  end

  # POST /vehicles
  # POST /vehicles.json
  def create
    @vehicle = @enterprise.vehicles.new(vehicle_params)

    respond_to do |format|
      if @vehicle.save
        format.html { redirect_to edit_vehicle_path(@vehicle), notice: 'Vehicle was successfully created.' }
        format.json { render :edit, status: :created, location: @vehicle }
      else
        format.html { render :new }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehicles/1
  # PATCH/PUT /vehicles/1.json
  def update
    respond_to do |format|
      if @vehicle.update(vehicle_params)
        format.html { redirect_to edit_vehicle_path(@vehicle), notice: 'Vehicle was successfully updated.' }
        format.json { render :edit, status: :ok, location: @vehicle }
      else
        format.html { render :edit }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicles/1
  # DELETE /vehicles/1.json
  def destroy
    @vehicle.destroy
    respond_to do |format|
      format.html { redirect_to vehicles_url, notice: 'Vehicle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle
      @vehicle = @enterprise.vehicles.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vehicle_params
      params.require(:vehicle).permit( :placa, :licencia, :clase, :marca, :tipo, :linea, :servicio, :combustible,
                                       :color, :modelo, :motor, :chasis, :serie, :fecha_de_compra, :contrato, :n_soat,
                                       :vencimiento_soat, :n_rtm, :vencimiento_rtm, :km_cambio_aceite,
                                       :km_proximocambio, :next_oil_change_date, pictures_attributes: [ :id, :image, :image_cache, :_destroy])
    end
end
