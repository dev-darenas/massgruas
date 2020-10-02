class AccountsController < EnterprisesController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  # GET /accounts
  # GET /accounts.json
  def index
    @q = @enterprise.accounts.ransack(params[:q])
    @pagy, @accounts = pagy( @q.result, items: params[:per_page] == 'all' ? @q.result.count : 10 )
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = @enterprise.accounts.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = @enterprise.accounts.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to edit_account_path(@account), notice: 'la cuenta ha sido creada satisfactoriamente.' }
        format.json { render :show, status: :created, location: @account }
        format.js
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to edit_account_path(@account), notice: 'La cuenta ha sido actualizada satisfactoriamente.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'La cuenta ha sido destruida satisfactoriamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = @enterprise.accounts.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(:name, :client_ids)
    end
end
