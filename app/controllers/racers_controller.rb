class RacersController < ApplicationController
  before_action :set_racer, only: %i[ show edit update destroy ]

  # GET /racers or /racers.json
  def index
    @racers = Racer.all
  end

  # GET /racers/1 or /racers/1.json
  def show
    @selected_race = params[:race_id] ? @racer.race_results.find(params[:race_id]) : @racer.race_results.first
    
    # Get current category from the most recent race result or current season
    @current_category = get_current_category
    
    # Group race results by year for organized display
    @race_results_by_year = @racer.race_results
                                  .includes(:race, :race_result_laps, :category)
                                  .joins(:race)
                                  .order('races.race_date DESC')
                                  .group_by { |result| result.race.race_date.year }
    
    # Determine the back path based on referer
    @back_path, @back_text = determine_back_path
  end

  # GET /racers/new
  def new
    @racer = Racer.new
  end

  # GET /racers/1/edit
  def edit
  end

  # POST /racers or /racers.json
  def create
    @racer = Racer.new(racer_params)

    respond_to do |format|
      if @racer.save
        format.html { redirect_to @racer, notice: "Racer was successfully created." }
        format.json { render :show, status: :created, location: @racer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @racer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /racers/1 or /racers/1.json
  def update
    respond_to do |format|
      if @racer.update(racer_params)
        format.html { redirect_to @racer, notice: "Racer was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @racer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @racer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /racers/1 or /racers/1.json
  def destroy
    @racer.destroy!

    respond_to do |format|
      format.html { redirect_to racers_path, notice: "Racer was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_racer
      @racer = Racer.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def racer_params
      params.fetch(:racer, {})
    end

    def get_current_category
      # Get most recent category from race results
      @racer.racer_seasons
            .joins(race_results: [:race, :category])
            .order('races.race_date DESC')
            .first&.race_results&.first&.category
    end

    def determine_back_path
      referer = request.referer
      
      if referer.present?
        case referer
        when /\/teams\/\d+/
          # Coming from a team page
          team_id = referer.match(/\/teams\/(\d+)/)[1]
          [team_path(team_id), "Back to Team"]
        when /\/races\/\d+/
          # Coming from a race page (when race routes are implemented)
          race_id = referer.match(/\/races\/(\d+)/)[1]
          ["/races/#{race_id}", "Back to Race"]
        when /\/racers/
          # Coming from racers index
          [racers_path, "Back to Racers"]
        else
          # Default fallback
          [racers_path, "Back to Racers"]
        end
      else
        # No referer, default to racers index
        [racers_path, "Back to Racers"]
      end
    end
end
