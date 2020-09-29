module Vehicles
  class DocumentsController < BaseController
    before_action :set_document, only: [:show, :edit, :update, :destroy]

    def index
      @q = @vehicle.documents.ransack(params[:q])
      @pagy, @documents = pagy(@q.result.includes(:document_type))
    end

    def new
      @document = @vehicle.documents.new
      @document.pictures.build
    end

    def create
      @document = @vehicle.documents.new(document_params)
      if @document.save
        redirect_to edit_vehicle_document_path(@vehicle, @document), notice: 'Document was successfully created.'
      else
        render :new
      end
    end

    def edit
      @document.pictures.build
    end

    def update
      if @document.update(document_params)
        redirect_to edit_vehicle_document_path(@vehicle, @document), notice: 'Document was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @document.destroy
      redirect_to vehicle_documents_path, notice: 'Document was deleted'
    end

    private

    def set_document
      @document = @vehicle.documents.find(params[:id])
    end

    def document_params
      params.require(:document).permit(:document_type_id, :renewable, :due_date,
                                       pictures_attributes: [:id, :image, :image_cache, :_destroy, attachments:[]]
      )
    end
  end
end
