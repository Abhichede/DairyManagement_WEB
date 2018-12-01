class DairyDetailsController < ApplicationController
  before_action :set_dairy_detail, only: [:show, :edit, :update, :destroy]

  # GET /dairy_details
  # GET /dairy_details.json
  def index
    @dairy_details = DairyDetail.all
  end

  # GET /dairy_details/1
  # GET /dairy_details/1.json
  def show
  end

  # GET /dairy_details/new
  def new
    @dairy_detail = DairyDetail.new
  end

  # GET /dairy_details/1/edit
  def edit
  end

  # POST /dairy_details
  # POST /dairy_details.json
  def create
    @dairy_detail = DairyDetail.new(dairy_detail_params)
    DairyDetail.all.first.destroy if DairyDetail.all.count > 0
    respond_to do |format|
      if @dairy_detail.save
        format.html { redirect_to @dairy_detail, notice: 'Dairy detail was successfully created.' }
        format.json { render :show, status: :created, location: @dairy_detail }
      else
        format.html { render :new }
        format.json { render json: @dairy_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dairy_details/1
  # PATCH/PUT /dairy_details/1.json
  def update
    respond_to do |format|
      if @dairy_detail.update(dairy_detail_params)
        format.html { redirect_to @dairy_detail, notice: 'Dairy detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @dairy_detail }
      else
        format.html { render :edit }
        format.json { render json: @dairy_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dairy_details/1
  # DELETE /dairy_details/1.json
  def destroy
    @dairy_detail.destroy
    respond_to do |format|
      format.html { redirect_to dairy_details_url, notice: 'Dairy detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dairy_detail
      @dairy_detail = DairyDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dairy_detail_params
      params.require(:dairy_detail).permit(:name, :address, :send_message)
    end
end
