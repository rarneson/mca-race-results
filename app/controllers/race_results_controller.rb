class RaceResultsController < ApplicationController
  before_action :set_race_result, only: %i[ show edit update destroy lap_data ]

  # GET /race_results or /race_results.json
  def index
    @race_results = RaceResult.all
  end

  # GET /race_results/1 or /race_results/1.json
  def show
  end

  # GET /race_results/new
  def new
    @race_result = RaceResult.new
  end

  # GET /race_results/1/edit
  def edit
  end

  # POST /race_results or /race_results.json
  def create
    @race_result = RaceResult.new(race_result_params)

    respond_to do |format|
      if @race_result.save
        format.html { redirect_to @race_result, notice: "Race result was successfully created." }
        format.json { render :show, status: :created, location: @race_result }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @race_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /race_results/1 or /race_results/1.json
  def update
    respond_to do |format|
      if @race_result.update(race_result_params)
        format.html { redirect_to @race_result, notice: "Race result was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @race_result }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @race_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /race_results/1 or /race_results/1.json
  def destroy
    @race_result.destroy!

    respond_to do |format|
      format.html { redirect_to race_results_path, notice: "Race result was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  # GET /race_results/1/lap_data.json
  def lap_data
    laps = @race_result.race_result_laps.order(:lap_number)
    
    render json: {
      laps: laps.map do |lap|
        {
          lap_number: lap.lap_number,
          lap_time_ms: lap.lap_time_ms,
          cumulative_time_ms: lap.cumulative_time_ms
        }
      end,
      total_time: @race_result.total_time_ms
    }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race_result
      @race_result = RaceResult.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def race_result_params
      params.fetch(:race_result, {})
    end
end
