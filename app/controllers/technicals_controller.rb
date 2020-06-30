class TechnicalsController < EnterpriseController
  before_action :set_technical, only: [:show, :edit, :update, :destroy]

  def index
    @technicals = Technical.all
  end

  def show

  end

  def new
    @technical = @enterprise.technicals.new
    @technical.pictures.build
  end

  def edit
  end

  def create
    @technical = @enterprise.technicals.new(technical_params)

    respond_to do |format|
      if @technical.save
        format.html { redirect_to edit_technical_path(@technical), notice: 'Technical was successfully created.' }
        format.json { render :edit, status: :created, location: @technical }
      else
        format.html { render :new }
        format.json { render json: @technical.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @technical.update(technical_params)
        format.html { redirect_to edit_technical_path(@technical), notice: 'Technical was successfully updated.' }
        format.json { render :edit, status: :ok, location: @technical }
      else
        format.html { render :edit }
        format.json { render json: @technical.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @technical.destroy
    respond_to do |format|
      format.html { redirect_to technicals_path, notice: 'Technical was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_technical
    @technical = Technical.find(params[:id])
  end

  def technical_params
    params.require(:technical).permit(:nombre, :cedula, :cargo, :direccion, :telefono1, :telefono2,
                                    :fecha_nacimiento, :estado_civil, :conyuge, :hijos, :n_licencia,
                                    :categoria, :eps, :arl, :vinculacion, :retiro,
                                    pictures_attributes: [:id, :image, :image_cache, :_destroy])
  end
end
