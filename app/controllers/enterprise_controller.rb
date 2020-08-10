class EnterpriseController < ApplicationController
  before_action :load_enterprise

  def edit
    unless @enterprise.pictures.count == 1
      @enterprise.pictures.build
    end
  end

  def update
    respond_to do |format|
      if @enterprise.update(enterprise_params)
        format.html { redirect_to edit_enterprise_path(@enterprise), notice: 'La empresa ha sido actualizada satisfactoriamente.' }
        format.json { render :edit, status: :ok, location: @enterprise }
      else
        format.html { render :edit }
        format.json { render json: @enterprise.errors, status: :unprocessable_entity }
      end
    end
  end

  def load_enterprise
    @enterprise = current_user&.enterprise
  end

  private

  def enterprise_params
    params.require(:enterprise).permit(pictures_attributes: [:id, :image, :image_cache, :_destroy])
  end
end
