class ClientsController < EnterprisesController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  # GET /clients
  # GET /clients.json
  def index
    @q = @enterprise.clients.ransack(params[:q])
    @pagy, @clients = pagy( @q.result, items: params[:per_page] == 'all' ? @q.result.count : 10 )
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    respond_to do |format|
      format.html
      format.json
      format.pdf do
        render pdf: "technical",
               template: "clients/show.html.slim",
               title: 'PDF  Cliente',
               layout: 'pdf'
      end
    end
  end

  # GET /clients/new
  def new
    @client = @enterprise.clients.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = @enterprise.clients.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to edit_client_path(@client), notice: 'El cliente ha sido creado satisfactoriamente.' }
        format.js
        format.json { render json: @client, status: :created }
      else
        format.html { render :new }
        format.js
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to  edit_client_path(@client), notice: 'El cliente ha sido actualizado satisfactoriamente.' }
        format.json { render :edit, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'El cliente ha sido destruido satisfactoriamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = @enterprise.clients.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_params
      params.require(:client).permit(:nombre, :tipo_identificacion, :identificacion, :razon_social, :regimen, :actividad_comercial,
                                     :direccion, :ciudad, :telefono, :email, account_ids: [])
    end
end
