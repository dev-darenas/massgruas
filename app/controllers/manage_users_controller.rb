class ManageUsersController < EnterpriseController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users=User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create

  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to  edit_manage_user_path(@user), notice: 'User was successfully updated.' }
        format.json { render :edit, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:fullname, :email, :rol)
  end
end
