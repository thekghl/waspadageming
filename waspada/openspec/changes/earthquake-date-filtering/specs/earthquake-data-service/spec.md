## MODIFIED Requirements

### Requirement: Fetch Earthquake Data
The service SHALL fetch the latest earthquake data for a specific date from the custom backend using `ApiConfig.baseUrl`.

#### Scenario: Successful data fetch with date
- **WHEN** the earthquake service requests earthquake data with a specific date
- **THEN** it sends a request to the backend with the `date` query parameter (e.g., `?date=2024-02-22`)
- **THEN** it receives a JSON response containing earthquake information for that date
- **THEN** it successfully parses the JSON into a list of strongly typed `Earthquake` model objects

## REMOVED Requirements

### Requirement: API Authentication
**Reason**: The new endpoint provided does not utilize the `EARTHQUAKE_API_KEY`.
**Migration**: Remove the authorization headers from the fetch request.
