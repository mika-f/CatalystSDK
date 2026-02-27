import type { Endpoint } from "./endpoint.js";
import type { EgeriaUpdateProfileRequest } from "../types/users.js";

export const EgeriaEndpoint = {
  me(): Endpoint {
    return { path: "/egeria/v1/me", method: "GET" };
  },

  update(data: EgeriaUpdateProfileRequest): Endpoint {
    return { path: "/egeria/v1/me", method: "PATCH", body: data };
  },

  search(q: string): Endpoint {
    return { path: "/egeria/v1/search", method: "GET", queryParameters: { q } };
  },

  userById(id: string): Endpoint {
    return { path: `/egeria/v1/user/by/id/${id}`, method: "GET" };
  },

  userByUsername(username: string): Endpoint {
    return { path: `/egeria/v1/user/by/username/${username}`, method: "GET" };
  },
} as const;
