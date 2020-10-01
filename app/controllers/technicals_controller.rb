class TechnicalsController < EnterprisesController
  before_action :set_technical, only: [:show, :edit, :update, :destroy]

  def index
    @q = @enterprise.technicals.ransack(params[:q])
    @pagy, @technicals = pagy( @q.result, items: params[:per_page] == 'all' ? @q.result.count : 10 )
  end

  def show
    respond_to do |format|
      format.html
      format.json
      format.pdf do
        render pdf: "technical",
               template: "technicals/show.html.slim",
               title: 'PDF  Tecnico',
               layout: 'pdf'
      end
    end
  end

  def new
    @technical = @enterprise.technicals.new
    @technical.pictures.build
  end

  def edit
    @technical.pictures.build
  end

  def create
    @technical = @enterprise.technicals.new(technical_params)

    respond_to do |format|
      if @technical.save
        format.html { redirect_to edit_technical_path(@technical), notice: 'El Técnico ha sido creado satisfactoriamente.' }
        format.json { render :edit, status: :created, location: @technical }
        format.js
      else
        format.html { render :new }
        format.json { render json: @technical.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @technical.update(technical_params)
        format.html { redirect_to edit_technical_path(@technical), notice: 'El Técnico ha sido actualizado satisfactoriamente.' }
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
      format.html { redirect_to technicals_path, notice: 'El Técnico ha sido destruido satisfactoriamente.' }
      format.json { head :no_content }
    end
  end

  private

  def set_technical
    @technical = @enterprise.technicals.find(params[:id])
  end

  def technical_params
    params.require(:technical).permit(:active, :nombre, :cedula, :cargo, :direccion, :telefono1, :telefono2,
                                    :fecha_nacimiento, :estado_civil, :conyuge, :hijos, :n_licencia,
                                    :categoria, :eps, :arl, :vinculacion, :retiro,
                                    pictures_attributes: [:id, :image, :image_cache, :_destroy, attachments: []])
  end
end
