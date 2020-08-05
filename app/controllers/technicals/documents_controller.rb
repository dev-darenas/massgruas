module Technicals
  class DocumentsController < BaseController
    before_action :set_document, only: [:show, :edit, :update, :destroy]

    def index
      @q = @technical.documents.ransack(params[:q])
      @pagy, @documents = pagy(@q.result.includes(:document_type))
    end

    def new
      @document = @technical.documents.new
      @document.pictures.build
    end

    def create
      @document = @technical.documents.new(document_params)
      if @document.save
        redirect_to edit_technical_document_path(@technical, @document), notice: 'Document was successfully created.'
      else
        render :new
      end
    end

    def edit
      @document.pictures.build
    end

    def update
      if @document.update(document_params)
        redirect_to edit_technical_document_path(@technical, @document), notice: 'Document was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @document.destroy
      redirect_to technical_documents_path, notice: 'Document was deleted'
    end

    private

    def set_document
      @document = @technical.documents.find(params[:id])
    end

    def document_params
      params.require(:document).permit(:document_type_id, :renewable, :due_date, 
        pictures_attributes: [ :id, :image, :image_cache, :_destroy]
      )
    end
  end
end
