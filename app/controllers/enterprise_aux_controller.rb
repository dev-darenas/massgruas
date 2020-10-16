class EnterpriseAuxController < ApplicationController
  before_action :set_enterprise, only: [:show, :edit, :update]
  def show
  end

  def new
    @enterprise = Enterprise.new
    @enterprise.pictures.build
    @enterprise.users.build
  end

  def edit
    unless @enterprise.pictures.count == 1
      @enterprise.pictures.build
    end
  end

  def create
    @enterprise = Enterprise.create(enterprise_params)

    if @enterprise.save
      redirect_to  edit_enterprise_aux_path(@enterprise), notice: 'La empresa ha sido creada satisfactoriamente.'
    else
      render :new
    end
  end

  def update
    if @enterprise.update(enterprise_params)
      redirect_to edit_enterprise_aux_path(@enterprise), notice: 'La empresa ha sido actualizada satisfactoriamente.'
    else
      render :edit
    end
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
