class TeamsController < ApplicationController
  before_action :set_team, only: %i[ show edit update destroy ]

  # GET /teams or /teams.json
  def index
    @teams = Team.all
    
    # Search functionality
    if params[:search].present?
      @teams = @teams.where("name like ?", "%#{params[:search]}%")
    end
    
    # Order by name for consistent display
    @teams = @teams.order(:name)
  end

  # GET /teams/1 or /teams/1.json
  def show
    # Load team and eager-load associations to avoid N+1 queries
    @team = Team.includes(racers: [
      { race_results: [:category, :race] }
    ]).find(params[:id])
    
    # Calculate team statistics
    @team_stats = calculate_team_stats(@team)
    
    # Group racers by category for roster display
    @racers_by_category = group_racers_by_category(@team.racers)
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
  
  def calculate_team_stats(team)
    all_race_results = team.racers.flat_map { |racer| racer.race_results }
    
    stats = {
      total_racers: team.racers.count,
      total_wins: all_race_results.count { |result| result.place == 1 },
      total_podiums: all_race_results.count { |result| result.place && result.place <= 3 },
      best_finish: all_race_results.map(&:place).compact.min || nil
    }
    
    stats
  end
  
  def group_racers_by_category(racers)
    # Get all race results with categories for these racers
    racers_with_categories = {}

    racers.each do |racer|
      # Get race results and their categories
      race_results = racer.race_results.includes(:category)
      categories = race_results.map(&:category).compact.uniq(&:id)
      
      
      # If no categories found in race results, racer is uncategorized
      if categories.empty?
        # Just add directly to uncategorized instead of creating an object
          racers_with_categories["Uncategorized"] ||= []
          unless racers_with_categories["Uncategorized"].any? { |existing_racer| existing_racer.id == racer.id }
            racers_with_categories["Uncategorized"] << racer
          end
          next # Skip the categories.each loop below
      end
      
      # Process each unique category for this racer
      seen_categories = Set.new
      categories.each do |category|
        category_name = category.name
        
        # Skip if we've already processed this category for this racer
        next if seen_categories.include?(category_name)
        seen_categories.add(category_name)
        
        racers_with_categories[category_name] ||= []
        unless racers_with_categories[category_name].any? { |existing_racer| existing_racer.id == racer.id }
          racers_with_categories[category_name] << racer
        end
      end
    end
    
    # Sort categories and racers, ensuring no duplicates
    sorted_categories = racers_with_categories.sort_by { |category_name, _| category_name }
    sorted_categories.to_h do |category_name, category_racers|
      [category_name, category_racers.uniq(&:id).sort_by { |r| r.last_name || '' }]
    end
  end
end
