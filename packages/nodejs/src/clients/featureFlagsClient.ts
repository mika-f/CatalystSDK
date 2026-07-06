import { FeatureFlagsEndpoint } from "../endpoints/featureFlagsEndpoint.js";
import type { HttpClient } from "./httpClient.js";
import type { FeatureFlagsResponse } from "../types/featureFlags.js";

/** Client for Feature Flags API endpoints. */
export class FeatureFlagsClient {
  constructor(private readonly http: HttpClient) {}

  /** Gets the feature flags enabled for the current user. */
  async me(): Promise<string[]> {
    const response = await this.http.request<FeatureFlagsResponse>(
      FeatureFlagsEndpoint.me(),
    );
    return response.flags;
  }
}
