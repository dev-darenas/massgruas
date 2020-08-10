class DocumentTypesController < EnterpriseController
  before_action :set_document_type, only: [:show, :edit, :update, :destroy]

  # GET /document_types
  # GET /document_types.json
  def index
    @q = @enterprise.document_types.ransack(params[:q])
    @pagy, @document_types = pagy( @q.result )
  end

  # GET /document_types/1
  # GET /document_types/1.json
  def show
  end

  # GET /document_types/new
  def new
    @document_type = @enterprise.document_types.new
  end

  # GET /document_types/1/edit
  def edit
  end

  # POST /document_types
  # POST /document_types.json
  def create
    @document_type = @enterprise.document_types.new(document_type_params)

    respond_to do |format|
      if @document_type.save
        format.html { redirect_to edit_document_type_path(@document_type), notice: 'El tipo de documento ha sido creado satisfactoriamente.' }
        format.json { render :edit, status: :created, location: @document_type }
      else
        format.html { render :new }
        format.json { render json: @document_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /document_types/1
  # PATCH/PUT /document_types/1.json
  def update
    respond_to do |format|
      if @document_type.update(document_type_params)
        format.html { redirect_to edit_document_type_path(@document_type), notice: 'El tipo de documento ha sido actualizado satisfactoriamente.' }
        format.json { render :edit, status: :ok, location: @document_type }
      else
        format.html { render :edit }
        format.json { render json: @document_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /document_types/1
  # DELETE /document_types/1.json
  def destroy
    @document_type.destroy
    respond_to do |format|
      format.html { redirect_to document_types_url, notice: 'El tipo de documento ha sido destruido satisfactoriamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document_type
      @document_type = @enterprise.document_types.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def document_type_params
      params.require(:document_type).permit(:name, :enterprise_id)
    end
end
