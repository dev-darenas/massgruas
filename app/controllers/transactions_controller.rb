class TransactionsController < EnterpriseController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy, :close, :deliver, :check_in]

  def index
    case params[:status]
    when 'open'
      @q = @enterprise.transactions.s_opened.ransack(params[:q])
      @pagy, @transactions = pagy( @q.result )
    when 'delivered'
      @q = @enterprise.transactions.s_delivered.ransack(params[:q])
      @pagy, @transactions = pagy( @q.result )
    when 'closed'
      @q = @enterprise.transactions.s_closed.ransack(params[:q])
      @pagy, @transactions = pagy( @q.result )
    when 'invoiced'
      @q = @enterprise.transactions.s_invoiced.ransack(params[:q])
      @pagy, @transactions = pagy( @q.result )
    else
      @q = @enterprise.transactions.ransack(params[:q])
      @pagy, @transactions = pagy( @q.result)
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json
      format.pdf do
        render pdf: "Transaction",
               template: "transactions/show.html.slim",
               title: 'PDF  Transaction',
               layout: 'pdf'
      end
    end
  end

  def new
    @transaction = @enterprise.transactions.new(fecha:Time.now.strftime("%Y-%m-%d %H:%M %z"),
                                                service_number: @enterprise.service_number,
                                                total_km: 0,
                                                km_zona_normal: 0,
                                                km_zona_roja:0)
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
    redirect_to transaction_path, notice: 'Transactions was successfully destroyed.'
  end

  def close
    respond_to do |format|
      if @transaction.close
        format.html { redirect_to edit_transaction_path(@transaction), notice: 'Transaction was successfully closed.' }
        format.json { render :edit, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
    end

  def deliver
    respond_to do |format|
      if @transaction.deliver
        format.html { redirect_to edit_transaction_path(@transaction), notice: 'Transaction was successfully delivered.' }
        format.json { render :edit, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
    end

  def check_in
    respond_to do |format|
      if @transaction.check_in
        format.html { redirect_to edit_transaction_path(@transaction), notice: 'Transaction was successfully invoiced.' }
        format.json { render :edit, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_transaction
    @transaction = @enterprise.transactions.find(params[:id])
  end

  def transaction_params
    unless params[:transaction][:technical].blank?

      params[:transaction][:technical_attributes] = {id: params[:transaction][:technical][:id],
                                                     telefono1: params[:transaction][:technical][:telefono1],
                                                     telefono2:params[:transaction][:technical][:telefono2]}
    end

    params.require(:transaction).permit(:status, :fecha, :orden_Trabajo, :service_number, :remision, :factura, :hora_llegada,
                                        :response_time, :hora_final, :client_id, :account_id, :expediente, :placa, :tarea, :origen,
                                        :lat, :lng, :destino, :latb, :lngb, :asegurado, :direccion, :telefono,
                                        :technical_id, :vehicle_id, :total_km, :km_zona_normal,:total_normal_zone,
                                        :km_zona_roja, :total_red_zone, :banderazo,
                                        :valor_km_zona_n, :valor_km_zona_r, :horas_de_espera, :waiting_hours_value,
                                        :total_waiting_hours, :rango_nocturno, :recargo_festivo, :valor_servicio,
                                        :priced, :operador, :celula_costo, :fecha_de_cierre,
                                        :descuento, :pago_total, :porcentaje_tecnico, :pago_tecnico, :combustible,
                                        :peajes, :gasto_viaje, :gastos, :ganancias, :service_id,
                                        observations_attributes: [:id, :user_id, :description, :_destroy],
                                        pictures_attributes: [:id, :image, :image_cache, :_destroy, attachments: []],
                                        client_attributes: [:nombre, :identificacion, :razon_social, :regimen,
                                                            :actividad_comercial, :direccion, :ciudad, :telefono,
                                                            :email, :enterprise_id],
                                        vehicle_attributes: [:enterprise_id, :placa, :licencia, :clase, :marca, :tipo, :linea, :servicio],
                                        technical_attributes: [:id, :enterprise_id, :nombre, :cedula, :cargo, :direccion, :telefono1,
                                                               :telefono2, :fecha_nacimiento, :n_licencia,
                                                               :categoria, :eps, :arl],
                                        account_attributes: [:name, :enterprise_id, :client_ids])


  end
end
