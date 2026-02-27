import type { Endpoint } from "./endpoint.js";

export const SteambirdEndpoint = {
  notifications(issuer: string, opts: { since?: string; until?: string } = {}): Endpoint {
    const params: Record<string, string> = { issuer };
    if (opts.since != null) params["since"] = opts.since;
    if (opts.until != null) params["until"] = opts.until;
    return { path: "/steambird/v1/notifications", method: "GET", queryParameters: params };
  },

  read(id: string): Endpoint {
    return { path: `/steambird/v1/notifications/${id}`, method: "POST" };
  },

  readAll(issuer?: string): Endpoint {
    return {
      path: "/steambird/v1/notifications/all",
      method: "POST",
      queryParameters: issuer != null ? { issuer } : undefined,
    };
  },

  unreads(issuers: string[] = []): Endpoint {
    return {
      path: "/steambird/v1/notifications/unread",
      method: "GET",
      queryParameters: issuers.length > 0 ? { issuers: issuers.join(",") } : undefined,
    };
  },
} as const;
