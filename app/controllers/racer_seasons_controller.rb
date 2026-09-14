class RacerSeasonsController < ApplicationController
  before_action :set_racer_season, only: %i[ show edit update destroy ]

  # GET /racer_seasons or /racer_seasons.json
  def index
    @racer_seasons = RacerSeason.all
  end

  # GET /racer_seasons/1 or /racer_seasons/1.json
  def show
  end

  # GET /racer_seasons/new
  def new
    @racer_season = RacerSeason.new
  end

  # GET /racer_seasons/1/edit
  def edit
  end

  # POST /racer_seasons or /racer_seasons.json
  def create
    @racer_season = RacerSeason.new(racer_season_params)

    respond_to do |format|
      if @racer_season.save
        format.html { redirect_to @racer_season, notice: "Racer season was successfully created." }
        format.json { render :show, status: :created, location: @racer_season }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @racer_season.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /racer_seasons/1 or /racer_seasons/1.json
  def update
    respond_to do |format|
      if @racer_season.update(racer_season_params)
        format.html { redirect_to @racer_season, notice: "Racer season was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @racer_season }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @racer_season.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /racer_seasons/1 or /racer_seasons/1.json
  def destroy
    @racer_season.destroy!

    respond_to do |format|
      format.html { redirect_to racer_seasons_path, notice: "Racer season was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_racer_season
      @racer_season = RacerSeason.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def racer_season_params
      params.fetch(:racer_season, {}).permit(:racer_id, :year, :plate_number)
    end
end
