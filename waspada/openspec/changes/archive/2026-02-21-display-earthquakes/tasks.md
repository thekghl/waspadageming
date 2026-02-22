## 1. Data Models and Service Setup

- [x] 1.1 Create `Earthquake` model class in `lib/models/` to parse the API JSON response
- [x] 1.2 Create `EarthquakeService` class in `lib/services/` to handle HTTP requests securely using `EARTHQUAKE_API_KEY` from `.env`

## 2. Map UI Integration

- [x] 2.1 Update map widget in `HomePage` (or relevant screen) to fetch earthquakes on initialization
- [x] 2.2 Add a new map layer or set of markers to render the fetched earthquakes based on their latitude and longitude
- [x] 2.3 Handle loading states and display errors gracefully (e.g., if the Cloudflare tunnel is offline)
