class TeamsController < ApplicationController
  include TeamsHelper
  before_action :set_team, only: %i[ show edit update destroy ]

  # GET /teams or /teams.json
  def index
    # Get selected year or default to current year
    @selected_year = params[:year]&.to_i || Date.current.year
    
    # Get available years for the dropdown
    @available_years = Race.distinct.pluck(:race_date).map(&:year).uniq.sort.reverse

    # Get teams that had racers compete in the selected year
    team_ids_with_racers = Team.joins(racers: { racer_seasons: { race_results: :race } })
                               .where(races: { race_date: Date.new(@selected_year, 1, 1)..Date.new(@selected_year, 12, 31) })
                               .distinct
                               .pluck(:id)

    # Get teams with racer counts for the year
    @teams = Team.where(id: team_ids_with_racers)
                 .left_joins(racers: { racer_seasons: { race_results: :race } })
                 .where(races: { race_date: Date.new(@selected_year, 1, 1)..Date.new(@selected_year, 12, 31) })
                 .group('teams.id')
                 .select('teams.*, COUNT(DISTINCT racers.id) as racers_count')

    # Search functionality
    if params[:search].present?
      @teams = @teams.where("teams.name like ?", "%#{params[:search]}%")
    end

    # Order by name for consistent display
    @teams = @teams.order('teams.name')

    # Calculate overall statistics for the selected year - use simpler approach
    @total_teams = team_ids_with_racers.count
    @total_racers = Racer.joins(racer_seasons: { race_results: :race })
                         .where(races: { race_date: Date.new(@selected_year, 1, 1)..Date.new(@selected_year, 12, 31) })
                         .distinct.count
  end

  # GET /teams/1 or /teams/1.json
  def show
    # Load team and eager-load associations to avoid N+1 queries
    @team = Team.includes(racers: [
      { race_results: [ :category, :race ] }
    ]).find(params[:id])

    # Get selected year or default to current year
    @selected_year = params[:year]&.to_i || Date.current.year

    # Get available years for the dropdown
    @available_years = Race.distinct.pluck(:race_date).map(&:year).uniq.sort.reverse

    # Calculate team statistics for the selected year
    @team_stats = calculate_team_stats(@team, @selected_year)

    # Group racers by category for roster display, filtered by year
    @racers_by_category = group_racers_by_category(@team.racers, @selected_year)
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams or /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: "Team was successfully created." }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1 or /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: "Team was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1 or /teams/1.json
  def destroy
    @team.destroy!

    respond_to do |format|
      format.html { redirect_to teams_path, notice: "Team was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_team
    @team = Team.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def team_params
    params.require(:team).permit(:name, :division)
  end

  def calculate_team_stats(team, year = Date.current.year)
    # Filter race results by year
    all_race_results = team.racers.flat_map do |racer|
      racer.race_results.joins(:race)
           .where(races: { race_date: Date.new(year, 1, 1)..Date.new(year, 12, 31) })
    end

    # Get unique racers who raced in the selected year
    racers_in_year = team.racers.joins(:race_results)
                         .joins("JOIN races ON race_results.race_id = races.id")
                         .where(races: { race_date: Date.new(year, 1, 1)..Date.new(year, 12, 31) })
                         .distinct

    stats = {
      total_racers: racers_in_year.count,
      total_wins: all_race_results.count { |result| result.place == 1 },
      total_podiums: all_race_results.count { |result| result.place && result.place <= 3 },
      best_finish: all_race_results.map(&:place).compact.min || nil
    }

    stats
  end
end
