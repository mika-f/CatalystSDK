import type { Endpoint } from "./endpoint.js";

export const FeatureFlagsEndpoint = {
  me(): Endpoint {
    return { path: "/feature-flags/v1/me", method: "GET" };
  },
} as const;
