## Why

The direct database integration attempt encountered `pg_hba.conf` connectivity issues (IP whitelisting/firewall) which are blocking development progress. The user wishes to revert the earthquake data fetching logic back to the previous API-based/static implementation to maintain stability while keeping the OneSignal remote trigger functionality intact.

## What Changes

- Revert `EarthquakeService` to use `http` and `ApiConfig.baseUrl` for fetching data.
- Restore the OneSignal App ID to the hardcoded version in `main.dart` as per the "previous setup".
- "Grey out" (comment out or keep unused) the `DatabaseService` and `.env` database variables.
- Keep the `Earthquake` model's `fromJson` factory as the primary data mapping logic.

## Capabilities

### Restored Capabilities
- `earthquake-data-service`: Returns to using the remote API tunnel (`loca.lt`).

## Impact

- `lib/services/earthquake_service.dart`: Restored to HTTP implementation.
- `lib/main.dart`: OneSignal initialization reverted to hardcoded ID.
- `lib/services/database_service.dart`: Becomes inactive/unused.
