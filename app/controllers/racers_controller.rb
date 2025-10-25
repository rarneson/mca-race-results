class RacersController < ApplicationController
  before_action :set_racer, only: %i[ show edit update destroy ]

  # GET /racers or /racers.json
  def index
    racers = Racer.all.order(:last_name, :first_name)

    if params[:search].present?
      @search_query = params[:search]
      search_term = "%#{@search_query}%"
      racers = racers.left_joins(:team).where(
        "racers.first_name LIKE ? OR racers.last_name LIKE ? OR teams.name LIKE ?",
        search_term, search_term, search_term
      ).distinct
    end

    if params[:team].present?
      @selected_team = params[:team]
      if @selected_team == "No Team"
        racers = racers.orphaned
      else
        racers = racers.joins(:team).where(teams: { name: @selected_team })
      end
    end

    @pagy, @racers = pagy(racers)
    @team_counts = calculate_team_counts

    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update(
            "racers_table",
            partial: "racers/racers_table",
            locals: { racers: @racers, pagy: @pagy }
          ),
          turbo_stream.update(
            "racers_count",
            partial: "racers/racers_count",
            locals: { count: @pagy.count }
          )
        ], content_type: "text/vnd.turbo-stream.html"
      end
    end
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

    def calculate_team_counts
      counts = {}

      Team.all.each do |team|
        counts[team.name] = team.racers.count
      end

      orphaned_count = Racer.orphaned.count
      counts["No Team"] = orphaned_count if orphaned_count > 0

      counts.sort_by { |name, _| name }.to_h
    end

    def determine_back_path
      referer = request.referer

      if referer.present?
        case referer
        when /\/teams\/([\w-]+)/
          # Coming from a team page
          team_slug = referer.match(/\/teams\/([\w-]+)/)[1]
          [team_path(team_slug), "Back to Team"]
        when /\/races\/([\w-]+)/
          # Coming from a race page
          race_slug = referer.match(/\/races\/([\w-]+)/)[1]
          [race_path(race_slug), "Back to Race"]
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
