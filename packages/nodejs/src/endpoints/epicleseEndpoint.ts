import type { Endpoint } from "./endpoint.js";
import type {
  EpicleseCreateAuthorRequest,
  EpicleseCreateWorldRequest,
  EpicleseCreateStatusMetadataTagRequest,
} from "../types/epiclese.js";

export const EpicleseEndpoint = {
  getAuthors(q?: string, platform?: string): Endpoint {
    const params: Record<string, string> = {};
    if (q != null) params["q"] = q;
    if (platform != null) params["platform"] = platform;
    return {
      path: "/epiclese/v1/authors",
      method: "GET",
      queryParameters: Object.keys(params).length > 0 ? params : undefined,
    };
  },

  createAuthor(data: EpicleseCreateAuthorRequest): Endpoint {
    return { path: "/epiclese/v1/authors", method: "POST", body: data };
  },

  getPlatforms(): Endpoint {
    return { path: "/epiclese/v1/platforms", method: "GET" };
  },

  getPlatform(id: string): Endpoint {
    return { path: `/epiclese/v1/platforms/${id}`, method: "GET" };
  },

  getStatusMetadata(statusId: string): Endpoint {
    return { path: `/epiclese/v1/tag/by/status/${statusId}`, method: "GET" };
  },

  createStatusMetadata(
    statusId: string,
    data: EpicleseCreateStatusMetadataTagRequest[],
  ): Endpoint {
    return {
      path: `/epiclese/v1/tag/by/status/${statusId}`,
      method: "POST",
      body: data,
    };
  },

  getWorlds(q?: string, platform?: string, offset?: number): Endpoint {
    const params: Record<string, string> = {};
    if (q != null) params["q"] = q;
    if (platform != null) params["platform"] = platform;
    if (offset != null) params["offset"] = String(offset);
    return {
      path: "/epiclese/v1/worlds",
      method: "GET",
      queryParameters: Object.keys(params).length > 0 ? params : undefined,
    };
  },

  createWorld(data: EpicleseCreateWorldRequest): Endpoint {
    return { path: "/epiclese/v1/worlds", method: "POST", body: data };
  },

  resolveWorld(platform: string, name: string): Endpoint {
    return {
      path: "/epiclese/v1/worlds/resolve",
      method: "GET",
      queryParameters: { platform, name },
    };
  },
} as const;
