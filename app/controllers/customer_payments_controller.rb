class CustomerPaymentsController < ApplicationController
  before_action :set_customer_payment, only: [:show, :edit, :update, :destroy]

  # GET /customer_payments
  # GET /customer_payments.json
  def index
    @customer_payments = CustomerPayment.all
  end

  # GET /customer_payments/1
  # GET /customer_payments/1.json
  def show
  end

  # GET /customer_payments/new
  def new
    @customers = Customer.all
    @customer_payment = CustomerPayment.new
  end

  # GET /customer_payments/1/edit
  def edit
    @customers = Customer.all
  end

  # POST /customer_payments
  # POST /customer_payments.json
  def create
    @customer_payment = CustomerPayment.new(customer_payment_params)

    respond_to do |format|
      if @customer_payment.save
        format.html { redirect_to @customer_payment, notice: 'Customer payment was successfully created.' }
        format.json { render :show, status: :created, location: @customer_payment }
      else
        format.html { render :new }
        format.json { render json: @customer_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customer_payments/1
  # PATCH/PUT /customer_payments/1.json
  def update
    respond_to do |format|
      if @customer_payment.update(customer_payment_params)
        format.html { redirect_to @customer_payment, notice: 'Customer payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer_payment }
      else
        format.html { render :edit }
        format.json { render json: @customer_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customer_payments/1
  # DELETE /customer_payments/1.json
  def destroy
    @customer_payment.destroy
    respond_to do |format|
      format.html { redirect_to customer_payments_url, notice: 'Customer payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_payment
      @customer_payment = CustomerPayment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_payment_params
      params.require(:customer_payment).permit(:customer_id, :date, :amount, :description)
    end
end
