# MCA Race Results

A Ruby on Rails application for managing and viewing Minnesota Cycling Association (MCA) mountain bike race results. The app imports race data, normalizes it across venues, and provides a web interface for browsing results by race, racer, team, and category.

## Tech Stack

- Ruby 3.4.5
- Rails 8.0
- SQLite3
- Hotwire (Turbo + Stimulus)
- TailwindCSS + daisyUI
- Deployed with Kamal + Docker

## Setup

```bash
# Install dependencies
bundle install

# Create database and run migrations
rails db:setup

# Or, if the database already exists
rails db:migrate
```

## Seeding Data

Race results are stored as individual seed files in `db/seeds/`. To seed everything (teams, categories, and all race data):

```bash
rails db:seed
```

To run a single seed file (useful when adding new races incrementally):

```bash
rake db:seed:file[2023_detroit_lakes]
```

The filename is passed without the `.rb` extension and corresponds to a file in `db/seeds/`.

## Running the App

```bash
rails server
```

## Tests

```bash
rails test
```

## Linting

```bash
rubocop
```
