## Why

The current implementation uses a `loca.lt` tunnel or a local API server. However, for maximum performance and direct data integrity in a development environment, the user wishes to have the Flutter app connect **directly** to the database (e.g., PostgreSQL or MySQL) without an API intermediary.

## What Changes

- Add a direct database driver dependency (such as `postgres` or `mysql1`) to `pubspec.yaml`.
- Implement a `DatabaseService` to manage the lifecycle of the database connection.
- Refactor `EarthquakeService` to perform SQL queries instead of HTTP requests.
- Update `.env` to store database credentials (Host, Port, User, Password, Database Name).

## Capabilities

### Modified Capabilities
- `earthquake-data-service`: Now uses the local development server as the primary data source.

## Impact

- `lib/config/api_config.dart`: The `baseUrl` will be updated.
- Network latency: Significant reduction by communicating directly over the local network instead of through a public tunnel.
