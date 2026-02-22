## ADDED Requirements

### Requirement: Direct Database Connection
The system SHALL establish a direct connection to a PostgreSQL database using credentials provided in environment variables.

#### Scenario: Database Initialization
- **WHEN** the app starts
- **THEN** the DatabaseService attempts to connect to the DB using `DB_HOST`, `DB_PORT`, `DB_USER`, `DB_PASSWORD`, and `DB_NAME`.

### Requirement: SQL-based Data Fetching
The system SHALL fetch earthquake records using a SQL `SELECT` statement instead of an HTTP GET request.

#### Scenario: Fetch by Date
- **WHEN** `EarthquakeService.fetchEarthquakes(date)` is called
- **THEN** it executes: `SELECT * FROM earthquakes WHERE date = $1` (or equivalent schema).
- **THEN** the results are mapped to `Earthquake` models.
