## ADDED Requirements

### Requirement: Fetch Earthquake Data
The service SHALL fetch the latest earthquake data from the custom Cloudflare API using `ApiConfig.baseUrl`.

#### Scenario: Successful data fetch
- **WHEN** the earthquake service requests earthquake data
- **THEN** it receives a JSON response containing earthquake information
- **THEN** it successfully parses the JSON into a list of strongly typed `Earthquake` model objects

### Requirement: API Authentication
The service SHALL include the `EARTHQUAKE_API_KEY` in the API request to authenticate with the custom backend.

#### Scenario: Request includes API key
- **WHEN** the earthquake service constructs the HTTP request
- **THEN** it attaches the `EARTHQUAKE_API_KEY` appropriately (e.g., via headers)

### Requirement: Error Handling
The service SHALL gracefully handle network errors or invalid responses from the Cloudflare tunnel.

#### Scenario: Cloudflare tunnel offline
- **WHEN** the Cloudflare tunnel is offline or the server returns a 5xx error
- **THEN** the service throws a handled exception instead of crashing the app
