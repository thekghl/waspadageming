## 1. Project Configuration

- [x] 1.1 Add `postgres: ^3.0.0` to `pubspec.yaml`
- [x] 1.2 Update `.env` with `DB_HOST`, `DB_PORT`, `DB_USER`, `DB_PASSWORD`, and `DB_NAME`

## 2. Core Implementation

- [x] 2.1 Create `DatabaseService` to handle Postgres connection and querying
- [x] 2.2 Refactor `EarthquakeService` to use `DatabaseService` instead of `http`
- [x] 2.3 Update `Earthquake.fromJson` (or add `fromRow`) to handle database result sets

## 3. Verification

- [ ] 3.1 Verify database connection in logs
- [ ] 3.2 Verify earthquake data is rendered correctly from the local DB
