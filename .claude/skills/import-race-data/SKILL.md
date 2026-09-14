---
name: import-race-data
description: Instructions and exact format requirements for importing race results data into seed files. Use when creating or modifying race result seed files.
---

# Importing Race Results Data

## Data Source

**All race result data must be provided by the user.** Never generate, guess, or fabricate race results. If the user hasn't provided data for a category, leave the array empty — do not fill it with placeholder or example data.

## Creating a New Race Seed File

When importing a new race, create a new seed file in `db/seeds/` by copying the template:

1. Copy `db/seeds/_template.rb` to a new file named after the race (e.g., `db/seeds/race_7_elm_creek.rb`)
2. Replace all placeholder values (RACE NUMBER, RACE NAME, DATE) with actual race data
3. Fill in the results arrays with the race data provided by the user
4. Keep the exact same file structure, helper method names, variable names, and division order as the template — only the race name and results data should differ

## Data Format - EXACT FORMAT REQUIRED

**CRITICAL: Follow these exact formats or data will be imported incorrectly**

### For 1 lap races:
- **Finished racers**: `[place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, nil, nil, nil, "finished", penalty, comments]`
- **DNF racers**: `[place, first_name, last_name, team_name, rider_number, plate, 0, "", "", nil, nil, nil, "DNF", penalty, comments]`

### For 2 lap races:
- **Finished racers**: `[place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, lap2_time, nil, nil, "finished", penalty, comments]`
- **DNF racers**: `[place, first_name, last_name, team_name, rider_number, plate, 0, "", "", "", nil, nil, "DNF", penalty, comments]`

### For 3 lap races:
- **Finished racers**: `[place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, lap2_time, lap3_time, nil, "finished", penalty, comments]`
- **DNF racers**: `[place, first_name, last_name, team_name, rider_number, plate, 0, "", "", "", "", nil, "DNF", penalty, comments]`

### For 4 lap races:
- **Finished racers**: `[place, first_name, last_name, team_name, rider_number, plate, laps, total_time, lap1_time, lap2_time, lap3_time, lap4_time, "finished", penalty, comments]`
- **DNF racers**: `[place, first_name, last_name, team_name, rider_number, plate, 0, "", "", "", "", nil, "DNF", penalty, comments]`

## Key Rules

1. **Status field**: Always "finished" for completed races, "DNF" for did not finish
2. **Empty fields**: Use `""` for missing times, `nil` for unused lap positions
3. **DNF format**: laps = 0, total_time = "", lap times = ""
4. **Field order matters**: place, names, team, numbers, laps, then times/status
5. **Penalty/Comment handling**: **CRITICAL - NEVER MISS THIS DATA**
   - **ALWAYS scan user-provided race data for ANY additional text, comments, penalties, or notes**
   - Add penalty as field after laps: `[..., laps, "penalty_amount", nil, total_time, ...]`
   - Add comments as field after penalty: `[..., laps, nil, "comment_text", total_time, ...]`
   - Add both if needed: `[..., laps, "penalty_amount", "comment_text", total_time, ...]`
   - **Examples of comments to capture**: "Deviation - relegate 3 spaces", "DNF - mechanical", "Time penalty", etc.
   - **If unsure whether something is penalty or comment, put it in comments field**
   - **NEVER exclude any additional data from the source** - all text must be preserved
6. **Always check existing seed files** in `db/seeds/` for working examples before creating new data
