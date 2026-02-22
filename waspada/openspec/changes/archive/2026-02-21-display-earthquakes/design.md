## Context

The Waspada application currently includes a map interface (like `HomePage`) but lacks real-time earthquake data visualization. A custom earthquake API has been made available via a local service, accessible remotely through a Cloudflare tunnel. Integrating this data into the app will enhance its disaster-awareness capabilities by explicitly plotting recent earthquakes on the map using their coordinates.

## Goals / Non-Goals

**Goals:**
- Fetch earthquake data using the custom Cloudflare URL (`ApiConfig.baseUrl`).
- Securely pass the `EARTHQUAKE_API_KEY` from the environment in the API requests.
- Parse the JSON response into strongly typed Dart models (`Earthquake` model).
- Display earthquake locations as markers on the existing map interface.

**Non-Goals:**
- Implementing push notifications for new earthquakes.
- Caching earthquake data offline; we will rely on fresh network fetches for now.
- Advanced filtering of earthquakes by magnitude or date in the UI (just displaying the default feed from the API).

## Decisions

1. **Service Layer Separation**: Create a dedicated `EarthquakeService` to handle HTTP requests to the custom Cloudflare API. This keeps the map UI components clean and encapsulates data fetching.
2. **Authentication Injection**: The `EARTHQUAKE_API_KEY` defined in `.env` will be passed via headers (e.g., `Authorization: Bearer <key>` or `x-api-key: <key>`, depending on the API's actual requirement).
3. **Map Integration**: Add a new marker layer to the existing map widget in `HomePage` that iterates through the fetched earthquake list and plots points based on latitude and longitude.

## Risks / Trade-offs

- **Risk: Cloudflare Tunnel Instability** -> The tunnel URL (`trycloudflare.com`) changes whenever the local tunnel is restarted by the host. *Mitigation*: Ensure `ApiConfig.baseUrl` is documented as the single source of truth for the URL and handle connection errors/timeouts gracefully in the UI with a snackbar.
- **Risk: Large Data Payloads** -> If the API returns thousands of earthquakes, rendering them might cause UI jank. *Mitigation*: Limit the number of parsed/rendered markers to a reasonable amount (e.g., top 50-100 most recent/significant) if pagination is not supported.
