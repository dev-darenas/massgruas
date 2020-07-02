class TransactionsController < EnterpriseController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  def index
    case params[:status]
    when 'open'
      @transactions = @enterprise.transactions.s_opened
    when 'delivered'
      @transactions = @enterprise.transactions.s_delivered
    when 'closed'
      @transactions = @enterprise.transactions.s_closed
    else
      @transactions = @enterprise.transactions
    end
  end

  def show
  end

  def new
    @transaction = @enterprise.transactions.new(status: 'open')
    @transaction.observations.build(user_id: current_user.id)
    @transaction.pictures.build
  end

  def edit
    @transaction.observations.build(user_id: current_user.id)
    @transaction.pictures.build
  end

  def create
    @transaction = @enterprise.transactions.new(transaction_params)
    respond_to do |format|
      if @transaction.save
        format.html { redirect_to edit_transaction_path(@transaction), notice: 'Transaction was successfully created.' }
        format.json { render :edit, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to edit_transaction_path(@transaction), notice: 'Transaction was successfully updated.' }
        format.json { render :edit, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transaction_url, notice: 'Transactions was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_transaction
    @transaction = @enterprise.transactions.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:status, :fecha, :orden_Trabajo, :remision, :factura, :hora_llegada,
                                        :hora_final, :client_id, :cuenta, :expediente, :placa, :tarea, :origen, :destino,
                                        :asegurado, :direccion, :telefono, :technical_id, :vehicle_id, :total_km,
                                        :km_zona_normal, :km_zona_roja, :banderazo, :valor_km_zona_n, :valor_km_zona_r,
                                        :horas_de_espera, :rango_nocturno, :recargo_festivo, :valor_servicio, :operador,
                                        :celula_costo, :fecha_de_cierre, :descuento, :pago_total, :porcentaje_tecnico,
                                        :pago_tecnico, :combustible, :peajes, :gasto_viaje, :gastos, :ganancias,
                                        observations_attributes: [:id, :user_id, :description, :_destroy],
                                        pictures_attributes: [:id, :image, :image_cache, :_destroy])


  end
end
