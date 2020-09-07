class EnterprisesController < ApplicationController
  before_action :load_enterprise

  def show
  end

  def new
    @newEnterprise = Enterprise.new
    @newEnterprise.pictures.build
    @newEnterprise.users.build
  end

  def edit
    unless @enterprise.pictures.count == 1
      @enterprise.pictures.build
    end
  end

  def create
    @newEnterprise = Enterprise.create(enterprise_params)

      if @newEnterprise.save
         redirect_to  edit_enterprise_path(@newEnterprise), notice: 'La empresa ha sido creada satisfactoriamente.'
      else
        render :new
      end
  end

  def update
      if @enterprise.update(enterprise_params)
        redirect_to edit_enterprise_path(@enterprise), notice: 'La empresa ha sido actualizada satisfactoriamente.'
      else
        render :edit
      end
  end

  def load_enterprise
    @enterprise = current_user&.enterprise
  end

  private

  def set_enterprise
    @enterprise = Enterprise.find(params[:id])
  end

  def enterprise_params
    params.require(:enterprise).permit(:name,
                                              users_attributes: [:fullname, :email, :password, :password_confirmation],
                                              pictures_attributes: [:id, :image, :image_cache, :_destroy])
  end
end
