import type { Endpoint } from "./endpoint.js";

export const SteambirdEndpoint = {
  notifications(
    issuer?: string,
    opts: { since?: string; until?: string } = {},
  ): Endpoint {
    const params: Record<string, string> = {};
    if (issuer != null) params["issuer"] = issuer;
    if (opts.since != null) params["since"] = opts.since;
    if (opts.until != null) params["until"] = opts.until;
    return {
      path: "/steambird/v1/notifications",
      method: "GET",
      queryParameters: Object.keys(params).length > 0 ? params : undefined,
    };
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

  unreads(issuer?: string, issuers: string[] = []): Endpoint {
    const params: Record<string, string> = {};
    if (issuer != null) params["issuer"] = issuer;
    if (issuers.length > 0) params["issuers"] = issuers.join(",");
    return {
      path: "/steambird/v1/notifications/unread",
      method: "GET",
      queryParameters: Object.keys(params).length > 0 ? params : undefined,
    };
  },
} as const;
