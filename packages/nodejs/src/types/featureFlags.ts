/** Wrapper for the `{"flags": [...]}` response shape of `GET /feature-flags/v1/me`. */
export interface FeatureFlagsResponse {
  flags: string[];
}
