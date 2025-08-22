# MCA Race Results - Project Context

## Project Overview
This is a Ruby on Rails 8.0 application for managing Minnesota Cycling Association (MCA) race results. The application imports race data from PDF files, normalizes the data, and provides a web interface for viewing results.

## Core Architecture

### Technology Stack
- **Framework**: Ruby on Rails 8.0.2
- **Database**: SQLite3 (development), likely PostgreSQL (production)
- **Frontend**: Hotwire (Turbo + Stimulus), TailwindCSS, daisyUI component library
- **PDF Processing**: pdf-reader gem
- **Deployment**: Kamal with Docker containers

### Key Models
- `Race`: Individual race events with metadata (name, date, location)
- `Racer`: Individual cyclists with personal info
- `Team`: Cycling teams that racers belong to
- `RaceResult`: Performance results linking racers to races
- `RaceResultLap`: Individual lap times within a race
- `Category`: Race categories (age groups, skill levels)
- `RacerSeason`: Tracks racer participation across seasons and, most importantly, the racers category at any given point in the year. A racer may be promoted to a new category mid-year.

### Data Import System
Located in `lib/race_data/`, this system:
- Parses PDF race results using venue-specific parsers
- Normalizes data formats across different race venues
- Validates and imports data into the database
- Handles team name extraction and matching

## Development Guidelines

### Code Style
- Follow Rails conventions and the project's existing patterns
- Use Rubocop Rails Omakase for linting (`rubocop`)
- No unnecessary comments unless complex logic requires explanation
- Prefer existing patterns over introducing new libraries

### File Organization
- Controllers in `app/controllers/` follow RESTful conventions
- Models in `app/models/` with appropriate validations and associations
- Views use ERB templates with Hotwire for dynamic behavior
- Race data parsers in `lib/race_data/` with venue-specific implementations

### Database
- Uses Rails migrations for schema changes
- SQLite for development, configure production database separately
- Foreign key relationships between core models
- Unique constraints on race results to prevent duplicates

### Testing
- Uses Rails default testing framework (Minitest)
- Test files in `test/` directory mirror app structure
- System tests use Capybara + Selenium WebDriver
- Run tests with: `rails test` (check for exact command)

### Import Tasks
- Race data import via `rails import:race_data` tasks
- Validation tasks available for checking data integrity
- 2024 PDF files stored in `lib/race_data/y2024_race_results/`

## Common Commands

### Development
```bash
# Start development server
rails server

# Run database migrations
rails db:migrate

# Seed data
rails db:seed

# Import race data
rake import:race_data

# Run linting
rubocop

# Run tests
rails test
```

### Key Directories
- `app/` - Main Rails application code
- `lib/race_data/` - PDF parsing and import logic
- `db/migrate/` - Database schema migrations
- `test/` - Test files
- `config/` - Application configuration

## Domain Knowledge

### Race Categories
The application handles various cycling race categories based on age groups and skill levels. Categories were recently refactored from embedded strings to a proper Category model.

### Team Management
Teams can be associated with racers. Team name extraction from race results is handled by specialized parsing logic. Due to complexity in parsing race data, some racers may be orphaned without a team association, and those will be manually associated later.

### PDF Parsing
Each race venue has its own PDF format, requiring venue-specific parsers that inherit from `BaseMcaParser`. Parsers extract race metadata, participant lists, and timing data.

## Recent Changes
- Removed gender field from racers model
- Converted from pills to dropdown for filtering UI
- Updated to use Category model instead of embedded category strings
- Theme updated to "emerald"

## When Working on This Project
1. Always check existing patterns before implementing new features
2. Test PDF parsing changes with actual race result files
3. Ensure data validation prevents duplicate or invalid race results
4. Follow Rails conventions for controller actions and model methods
5. Use the existing Hotwire setup for dynamic UI interactions
6. Provide tests for new or modified functionality