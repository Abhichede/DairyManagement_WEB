class DailyCollectionsController < ApplicationController
  before_action :set_daily_collection, only: [:show, :edit, :update, :destroy]

  # GET /daily_collections
  # GET /daily_collections.json
  def index
    @daily_collections = DailyCollection.all
  end

  # GET /daily_collections/1
  # GET /daily_collections/1.json
  def show
  end

  # GET /daily_collections/new
  def new
    @customers = Customer.all
    @daily_collection = DailyCollection.new
  end

  # GET /daily_collections/1/edit
  def edit
    @customers = Customer.all
  end

  # POST /daily_collections
  # POST /daily_collections.json
  def create
    @daily_collection = DailyCollection.new(daily_collection_params)
    @daily_collection.date = Date.today
    @daily_collection.time = Time.now

    respond_to do |format|
      if @daily_collection.save
        format.html { redirect_to @daily_collection, notice: 'Daily collection was successfully created.' }
        format.json { render :show, status: :created, location: @daily_collection }
      else
        format.html { render :new }
        format.json { render json: @daily_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /daily_collections/1
  # PATCH/PUT /daily_collections/1.json
  def update
    respond_to do |format|
      if @daily_collection.update(daily_collection_params)
        format.html { redirect_to @daily_collection, notice: 'Daily collection was successfully updated.' }
        format.json { render :show, status: :ok, location: @daily_collection }
      else
        format.html { render :edit }
        format.json { render json: @daily_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /daily_collections/1
  # DELETE /daily_collections/1.json
  def destroy
    @daily_collection.destroy
    respond_to do |format|
      format.html { redirect_to daily_collections_url, notice: 'Daily collection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def payment_register
    unless params[:from_date] == nil && params[:to_date] == nil
      @daily_collections = DailyCollection.select("sum(total_price) as total_price, avg(rate) as rate, avg(fat) as fat, avg(snf) snf, customer_id as customer_id, sum(litre) as litre").where(date: params[:from_date]..params[:to_date]).group("customer_id")
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: 'Payment_register', encoding: 'UTF-8'
        end
      end
    end
  end

  def daily_report
    unless params[:date] == nil
      @daily_collections = DailyCollection.where(date: params[:date])
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: 'Daily_report', encoding: 'UTF-8'
        end
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_daily_collection
      @daily_collection = DailyCollection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def daily_collection_params
      params.require(:daily_collection).permit(:customer_id, :date, :time, :shift, :litre, :fat, :lacto, :snf, :water_level, :rate, :total_price)
    end
end
