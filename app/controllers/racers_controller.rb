class RacersController < ApplicationController
  include BackNavigable
  before_action :set_racer, only: %i[ show edit update destroy ]

  # GET /racers or /racers.json
  def index
    # Get selected year or default to "All"
    @selected_year = params[:year].present? && params[:year] != "" ? params[:year] : "All"

    # Get available years for the dropdown
    @available_years = Race.distinct.pluck(:race_date).map(&:year).uniq.sort.reverse

    # Start with base racers query
    if @selected_year == "All"
      # Show all racers regardless of year
      racers = Racer.all.order(:last_name, :first_name)
    else
      # Filter racers who competed in the selected year
      year_int = @selected_year.to_i
      racers = Racer.joins(racer_seasons: { race_results: :race })
                    .where(races: { race_date: Date.new(year_int, 1, 1)..Date.new(year_int, 12, 31) })
                    .distinct
                    .order(:last_name, :first_name)
    end

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
    @team_counts = calculate_team_counts(@selected_year)

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
            locals: { count: @pagy.count, selected_year: @selected_year }
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
    
    @back_path, @back_text = determine_back_path(default_path: racers_path, default_text: "Back to Racers")
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

    def calculate_team_counts(year = "All")
      counts = {}

      if year == "All"
        # Count all racers for each team
        Team.all.each do |team|
          racer_count = team.racers.count
          counts[team.name] = racer_count if racer_count > 0
        end

        # Count all orphaned racers
        orphaned_count = Racer.orphaned.count
        counts["No Team"] = orphaned_count if orphaned_count > 0
      else
        # Count racers who competed in the selected year
        year_int = year.to_i
        Team.all.each do |team|
          racer_count = team.racers
                            .joins(racer_seasons: { race_results: :race })
                            .where(races: { race_date: Date.new(year_int, 1, 1)..Date.new(year_int, 12, 31) })
                            .distinct
                            .count
          counts[team.name] = racer_count if racer_count > 0
        end

        # Count orphaned racers who competed in the selected year
        orphaned_count = Racer.orphaned
                               .joins(racer_seasons: { race_results: :race })
                               .where(races: { race_date: Date.new(year_int, 1, 1)..Date.new(year_int, 12, 31) })
                               .distinct
                               .count
        counts["No Team"] = orphaned_count if orphaned_count > 0
      end

      counts.sort_by { |name, _| name }.to_h
    end

end
