class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /customers
  # GET /customers.json
  def index
    if params[:customer_name]
      @customers = Customer.where("name LIKE '%#{params[:customer_name]}%'")
    else
      @customers = Customer.all
    end

  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    from_date = params[:from_date].nil? ? '1900-01-01' : params[:from_date]
    to_date = params[:to_date].nil? ? '3000-01-01 ' : params[:to_date]
    if from_date.nil?
      @daily_collections = @customer.daily_collections
    else
      @daily_collections = @customer.daily_collections.where(date: from_date..to_date)
    end

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'collection', encoding: 'UTF-8'
      end
    end
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)
    @customer.user = current_user

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    @customer.user = current_user
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:name, :contact, :address, :cattle_type)
    end
end
