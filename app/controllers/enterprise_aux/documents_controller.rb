module EnterpriseAux
  class DocumentsController < EnterprisesController
    before_action :set_document, only: [:show, :edit, :update, :destroy]

    def index
      @q = @enterprise.documents.ransack(params[:q])
      @pagy, @documents = pagy(@q.result.includes(:document_type))
    end

    def new
      @document = @enterprise.documents.new
      @document.pictures.build
    end

    def create
      @document = @enterprise.documents.new(document_params)
      if @document.save
        redirect_to edit_enterprise_aux_document_path(@enterprise, @document), notice: 'Documento creado'
      else
        render :new
      end
    end

    def edit
      @document.pictures.build
    end

    def update
      if @document.update(document_params)
        redirect_to edit_enterprise_aux_document_path(@enterprise, @document), notice: 'Documento actualizado correctamente'
      else
        render :edit
      end
    end

    def destroy
      @document.destroy
      redirect_to enterprise_aux_documents_path, notice: 'Document was deleted'
    end


    def show
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "Documentos #{@enterprise.name}",
                 title: "PDF Documentos #{@enterprise.name}",
                 layout: 'pdf'
        end
      end
    end

    private

    def set_document
      @document = @enterprise.documents.find(params[:id])
    end

    def document_params
      params.require(:document).permit(:document_type_id, :renewable, :due_date,
                                       pictures_attributes: [:id, :image, :image_cache, :_destroy, attachments:[]]
      )
    end
  end
end
