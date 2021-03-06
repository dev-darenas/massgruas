class ManageUsersController < EnterprisesController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @q = @enterprise.users.ransack(params[:q])
    @pagy, @users = pagy( @q.result )
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = @enterprise.users.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to  edit_manage_user_path(@user), notice: 'El usuario ha sido creado satisfactoriamente.' }
        format.json { render :edit, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to  edit_manage_user_path(@user), notice: 'El usuario ha sido actualizado satisfactoriamente.' }
        format.json { render :edit, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to manage_users_path, notice: 'El usuario ha sido destruido satisfactoriamente.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = @enterprise.users.find(params[:id])
  end

  def user_params
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    params.require(:user).permit(:fullname, :email, :rol, :password, :password_confirmation)
  end
end
