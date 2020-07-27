module Clients
  class DocumentsController < BaseController
    before_action :set_document, only: [:show, :edit, :update, :destroy]

    def index
      @pagy, @documents = pagy( @client.documents)
    end

    def new
      @document = @client.documents.new
      @document.pictures.build
    end

    def create
      @document = @client.documents.new(document_params)
      if @document.save
        redirect_to edit_client_document_path(@client, @document), notice: 'Document was successfully created.'
      else
        render :new
      end
    end

    def update
      if @document.update(document_params)
        redirect_to edit_client_document_path(@client, @document), notice: 'Document was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @document.destroy
      redirect_to client_documents_path, notice: 'Document was deleted'
    end

    private

    def set_document
      @document = @client.documents.find(params[:id])
    end

    def document_params
      params.require(:document).permit(:document_type_id, :renewable, :due_date, 
        pictures_attributes: [ :id, :image, :image_cache, :_destroy]
      )
    end
  end
end
