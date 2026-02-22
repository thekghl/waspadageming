## Context

The user wants to replace the current API-based earthquake fetching with a direct database connection (viewable in DBeaver). This allows for lower latency and better data synchronization during development.

## Goals

- Connect Flutter app directly to a PostgreSQL database.
- Refactor `EarthquakeService` to use SQL queries.
- Manage database connection lifecycle via a dedicated `DatabaseService`.

## Decisions

1. **Driver Selection**: Use the `postgres` package for direct communication.
2. **Environment Configuration**: Store all DB credentials in `.env` to avoid hardcoding.
3. **Singleton Pattern**: Implement `DatabaseService` as a singleton to maintain a single connection pool.

## Risks / Trade-offs

- **Security**: Direct DB connection in a mobile app is usually risky for production as it exposes credentials. *Mitigation*: This is strictly for the user's local development environment. 
- **Platform Support**: Direct DB drivers often require native socket support, which works well on Android/iOS but might need configuration for certain environments.
