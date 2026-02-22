## RESTORED Requirements

### Requirement: API-based Earthquake Fetching
The system SHALL fetch earthquake data from the endpoint defined in `ApiConfig.baseUrl` using the `http` package.

#### Scenario: Fetch by Date
- **WHEN** `EarthquakeService.fetchEarthquakes(date)` is called
- **THEN** it sends a GET request to `${baseUrl}earthquakes?date=$date`.
- **THEN** it parses the JSON response using `Earthquake.fromJson`.

### Requirement: Hardcoded OneSignal Initialization
The system SHALL initialize OneSignal using a hardcoded App ID in `main.dart`.
