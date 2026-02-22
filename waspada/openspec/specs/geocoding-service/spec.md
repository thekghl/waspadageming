# Spec: Geocoding Service

## Overview
The `geocoding-service` capability is responsible for taking a user-provided text query and requesting geographic coordinates (latitude and longitude) along with formatted address names from a remote geocoding API.

## States & Transitions
- **Idle**: No request is currently in flight.
- **Fetching**: An HTTP request has been sent to the geocoding API and the service is awaiting a response.
- **Success**: The API returned a 200 OK response with a valid JSON array of results. The results are parsed and ready to be displayed.
- **Error**: The API request failed due to network issues, a non-200 HTTP status code, or JSON parsing errors.
- **Transition `fetchResults`**: Moves from Idle to Fetching, and then to either Success or Error depending on the network outcome.

## Core Rules
1.  **API Endpoint**: Standard usage of the OpenStreetMap Nominatim API: `https://nominatim.openstreetmap.org/search?q={query}&format=jsonv2&addressdetails=1`
2.  **Rate Limiting Requirement**: Nominatim Usage Policy STRICTLY requires that requests are limited to an absolute maximum of 1 request per second. Therefore, the service MUST NOT be called on every keystroke. It must only be called via a debouncer.
3.  **User-Agent**: To comply with the Nominatim API free-tier usage policy, the HTTP request headers SHOULD include a descriptive `User-Agent`.
4.  **Error Handling**: The service must never crash the app. It must catch `SocketException` (no internet), `TimeoutException`, and HTTP status errors, and bubble up a safe empty list or throw a handled custom exception.

## Edge Cases
-   **Empty Query**: If the query is empty or just whitespace, the service should immediately return an empty list without making a network call.
-   **No Internet**: If the device is offline, the service must catch the socket exception and return gracefully so the UI can inform the user.
-   **No Results**: The API returns an empty JSON array `[]` when the location is not found. The service should handle this natively and return an empty Dart List.
-   **Malformed JSON**: If the API changes or returns invalid JSON, the service should catch the `FormatException` and treat it as a standard fetch error.
