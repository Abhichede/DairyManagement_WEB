class RateChartsController < ApplicationController
  before_action :set_rate_chart, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /rate_charts
  # GET /rate_charts.json
  def index
    @rate_charts = RateChart.where(cattle_type: params[:cattle_type])
  end

  # GET /rate_charts/1
  # GET /rate_charts/1.json
  def show
  end

  # GET /rate_charts/new
  def new
    @rate_chart = RateChart.new
  end

  # GET /rate_charts/1/edit
  def edit
  end

  # POST /rate_charts
  # POST /rate_charts.json
  def create

    @rate_charts = RateChart.where(cattle_type: rate_chart_params[:cattle_type])
    unless @rate_charts.nil?
      # @rate_charts.each do |rate|
      #   rate.destroy
      # end
      @rate_charts.destroy_all
    end
    left = rate_chart_params[:left].to_f
    right = rate_chart_params[:right].to_f
    top = rate_chart_params[:top].to_f
    bottom = rate_chart_params[:bottom].to_f

    base_rate = rate_chart_params[:base_rate].to_f

    exLeft = 0
    exright = 0
    exTop = 0
    exBottom = 0
    baseSNF = 8.5
    baseFAT = 3.5

    data = Array.new

    cattle_type_ = rate_chart_params[:cattle_type]

    puts "CAttle: #{cattle_type_} , Base Rate: #{base_rate}"

    if cattle_type_ === 'BUFFALO'
      exLeft = 7.5
      exright = 9.5
      exTop = 5.0
      exBottom = 9.4
      baseSNF = 9.0
      baseFAT = 6.0

    elsif cattle_type_ === 'COW'
      exLeft = 7.0
      exright = 9.0
      exTop = 2.5
      exBottom = 6.0
      baseSNF = 8.5
      baseFAT = 3.5
    end

    # i = baseSNF
    # j = baseFAT
    current_rate = base_rate

    (baseSNF.round(2)).step(exLeft.round(2), -0.1.round(2)) do |i|
      rate = current_rate.round(2)

      (baseFAT.round(2)).step(exTop.round(2), -0.1.round(2)) do |j|
        data.push({
                  cattle_type: cattle_type_,
                  snf: i.round(2),
                  fat: j.round(2),
                  rate: rate.round(2)
                  })
        rate = rate.round(2) - top.round(2)
      end
      current_rate = current_rate.round(2) - left.round(2)
    end

    current_rate = base_rate.round(2) + right.round(2)

    (baseSNF.round(2) + 0.1.round(2)).step(exright.round(2), 0.1.round(2)) do |i|
      rate = current_rate.round(2)

      (baseFAT.round(2)).step(exTop.round(2), -0.1.round(2)) do |j|
        data.push({
                      cattle_type: cattle_type_,
                      snf: i.round(2),
                      fat: j.round(2),
                      rate: rate.round(2)
                  })
        rate = rate.round(2) - top.round(2)
      end
      current_rate = current_rate.round(2) + right.round(2)
    end

    current_rate = base_rate.round(2) + bottom.round(2)

    (baseSNF.round(2)).step(exright.round(2), 0.1.round(2)) do |i|
      rate = current_rate.round(2)

      (baseFAT.round(2) + 0.1.round(2)).step(exBottom.round(2), 0.1.round(2)) do |j|
        data.push({
                      cattle_type: cattle_type_,
                      snf: i.round(2),
                      fat: j.round(2),
                      rate: rate.round(2)
                  })
        rate = rate.round(2) + bottom.round(2)
      end
      current_rate = current_rate.round(2) + right.round(2)
    end

    current_rate = (base_rate.round(2) + bottom.round(2)) - left.round(2)

    (baseSNF.round(2) - 0.1.round(2)).step(exLeft.round(2), -0.1.round(2)) do |i|
      rate = current_rate.round(2)

      (baseFAT.round(2) + 0.1.round(2)).step(exBottom.round(2), 0.1.round(2)) do |j|
        data.push({
                      cattle_type: cattle_type_,
                      snf: i.round(2),
                      fat: j.round(2),
                      rate: rate.round(2)
                  })
        rate = rate.round(2) + bottom.round(2)
      end
      current_rate = current_rate.round(2) - left.round(2)
    end

    puts data
    respond_to do |format|
      if RateChart.create(data)
        format.html { redirect_to rate_charts_path(cattle_type: cattle_type_), notice: 'Rate chart was successfully created.' }
      else
        format.html { redirect_to rate_charts_url, alert: 'Something went wrong while adding rates.' }
      end
    end
    # @rate_chart = RateChart.new(rate_chart_params)

    # respond_to do |format|
    #   if @rate_chart.save
    #     format.html { redirect_to @rate_chart, notice: 'Rate chart was successfully created.' }
    #     format.json { render :show, status: :created, location: @rate_chart }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @rate_chart.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /rate_charts/1
  # PATCH/PUT /rate_charts/1.json
  def update
    respond_to do |format|
      if @rate_chart.update(rate_chart_params)
        format.html { redirect_to @rate_chart, notice: 'Rate chart was successfully updated.' }
        format.json { render :show, status: :ok, location: @rate_chart }
      else
        format.html { render :edit }
        format.json { render json: @rate_chart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rate_charts/1
  # DELETE /rate_charts/1.json
  def destroy
    @rate_chart.destroy
    respond_to do |format|
      format.html { redirect_to rate_charts_url, notice: 'Rate chart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def rate_by_snf_and_fat
    @rate_chart = RateChart.find_by(snf: params[:snf], fat: params[:fat], cattle_type: params[:cattle_type])

    respond_to do |format|
      if @rate_chart
        format.json {render json: @rate_chart}
      else
        format.json {render json: {error: "No Rate found."}}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rate_chart
      @rate_chart = RateChart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rate_chart_params
      params.require(:rate_chart).permit(:cattle_type, :snf, :fat, :rate, :left, :right, :top, :bottom, :base_rate)
    end
end
