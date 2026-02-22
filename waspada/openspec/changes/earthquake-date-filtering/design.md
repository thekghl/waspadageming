## Context

The earthquake service is being updated to support a new API endpoint on `loca.lt`. This endpoint requires a `date` query parameter and doesn't seem to require the previously used API key for authentication.

## Goals / Non-Goals

**Goals:**
- Update `EarthquakeService` to accept a `date` parameter.
- Transition API calls to use the new Query Parameter structure (`/earthquakes?date=...`).
- Ensure the base URL from `ApiConfig` is used correctly (handling potential double slashes).

**Non-Goals:**
- Implementing a date picker in the UI (for this phase, we will use a default current date).
- Caching results by date.

## Decisions

1. **Parameterization**: `EarthquakeService.fetchEarthquakes` will now require a `String date`. This enforces clarity on which data is being requested.
2. **Simplified Connectivity**: We will remove the `EARTHQUAKE_API_KEY` header as the new `loca.lt` proxy provided in the user snippet does not include it. We will add it back if the service eventually requires it.
3. **Url Formatting**: Since `ApiConfig.baseUrl` ends in a `/`, we will ensure the path appended doesn't start with a duplicate slash.

## Risks / Trade-offs

- **Risk: Breaking Change** -> Any component calling `fetchEarthquakes` will break until updated. *Mitigation*: Simultaneously update `HomePage` to provide the required date.
- **Risk: Date Formatting** -> The API might expect a specific format (e.g., YYYY-MM-DD). *Mitigation*: Handle formatting in the caller or service.
