## Context

Rollback of the direct database integration due to connectivity blockers.

## Goals

- Restore working earthquake data fetching via API.
- Ensure OneSignal remains functional with the user's preferred "previous" configuration.
- Cleanup/disable unused database-related code.

## Decisions

1. **Service Reversion**: `EarthquakeService.fetchEarthquakes` will use the `http` package and `ApiConfig`.
2. **OneSignal Setup**: Revert `main.dart` logic to the state where the ID was hardcoded, as requested by the user.
3. **Database Code**: `DatabaseService.dart` will be left in the codebase but will no longer be called.

## Risks / Trade-offs

- **Performance**: Returning to the remote tunnel (`loca.lt`) may introduce some latency compared to local access, but it ensures connectivity.
