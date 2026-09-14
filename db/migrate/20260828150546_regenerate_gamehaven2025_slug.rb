class RegenerateGamehaven2025Slug < ActiveRecord::Migration[8.1]
  # The prior migration corrected race.year via update!, but Race#generate_slug
  # only fires when the slug is blank or the name changed, so the slug (and the
  # header, which renders it) was left as "2024-...". Blanking the slug forces
  # regeneration on save. Idempotent and keyed on natural attributes.
  def up
    race = Race.find_by(name: "Race 4S - Gamehaven Rochester", race_date: Date.new(2025, 9, 20))
    return say("Race not found; nothing to do.") unless race

    race.year = 2025
    race.slug = nil
    race.save!

    say("Regenerated slug: #{race.slug}")
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
