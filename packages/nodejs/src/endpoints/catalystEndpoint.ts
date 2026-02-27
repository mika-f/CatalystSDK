import type { Endpoint } from "./endpoint.js";
import type {
  CatalystCreateAlbumRequest,
  CatalystEditAlbumRequest,
  CatalystInsertToAlbumRequest,
  CatalystRemoveFromAlbumRequest,
  CatalystCreateSmartAlbumRequest,
  CatalystEditSmartAlbumRequest,
} from "../types/albums.js";
import type { CatalystCreateStatusRequest, CatalystEditStatusRequest } from "../types/status.js";
import type { CatalystRelationshipRequest } from "../types/relationships.js";

function buildTimelineParams(opts: { since?: string; until?: string }): Record<string, string> | undefined {
  const params: Record<string, string> = {};
  if (opts.since != null) params["since"] = opts.since;
  if (opts.until != null) params["until"] = opts.until;
  return Object.keys(params).length > 0 ? params : undefined;
}

export const CatalystEndpoint = {
  createAlbum(data: CatalystCreateAlbumRequest): Endpoint {
    return { path: "/catalyst/v1/album", method: "POST", body: data };
  },

  getAlbum(id: string, opts: { since?: string; until?: string } = {}): Endpoint {
    return {
      path: `/catalyst/v1/album/by/id/${id}`,
      method: "GET",
      queryParameters: buildTimelineParams(opts),
    };
  },

  editAlbum(id: string, data: CatalystEditAlbumRequest): Endpoint {
    return { path: `/catalyst/v1/album/by/id/${id}`, method: "PATCH", body: data };
  },

  insertToAlbum(id: string, data: CatalystInsertToAlbumRequest): Endpoint {
    return { path: `/catalyst/v1/album/by/id/${id}`, method: "PUT", body: data };
  },

  removeFromAlbum(id: string, data: CatalystRemoveFromAlbumRequest): Endpoint {
    return { path: `/catalyst/v1/album/by/id/${id}`, method: "PUT", body: data };
  },

  deleteAlbum(id: string): Endpoint {
    return { path: `/catalyst/v1/album/by/id/${id}`, method: "DELETE" };
  },

  listAlbums(username: string, includeSmartAlbums = false): Endpoint {
    return {
      path: `/catalyst/v1/album/by/user/${username}`,
      method: "GET",
      queryParameters: { include_smart_albums: String(includeSmartAlbums) },
    };
  },

  searchAlbum(q: string, includeSmartAlbums = false): Endpoint {
    return {
      path: "/catalyst/v1/album/search",
      method: "GET",
      queryParameters: { q, include_smart_album: String(includeSmartAlbums) },
    };
  },

  customReactions(): Endpoint {
    return { path: "/catalyst/v1/reactions", method: "GET" };
  },

  relationships(id: string): Endpoint {
    return { path: `/catalyst/v1/relationships/${id}`, method: "GET" };
  },

  follow(data: CatalystRelationshipRequest): Endpoint {
    return { path: "/catalyst/v1/relationships", method: "POST", body: data };
  },

  remove(data: CatalystRelationshipRequest): Endpoint {
    return { path: "/catalyst/v1/relationships", method: "DELETE", body: data };
  },

  createSmartAlbum(data: CatalystCreateSmartAlbumRequest): Endpoint {
    return { path: "/catalyst/v1/smart-album", method: "POST", body: data };
  },

  getSmartAlbum(id: string, opts: { since?: string; until?: string } = {}): Endpoint {
    return {
      path: `/catalyst/v1/smart-album/by/id/${id}`,
      method: "GET",
      queryParameters: buildTimelineParams(opts),
    };
  },

  editSmartAlbum(id: string, data: CatalystEditSmartAlbumRequest): Endpoint {
    return { path: `/catalyst/v1/smart-album/by/id/${id}`, method: "PATCH", body: data };
  },

  deleteSmartAlbum(id: string): Endpoint {
    return { path: `/catalyst/v1/smart-album/by/id/${id}`, method: "DELETE" };
  },

  searchSmartAlbum(q: string): Endpoint {
    return { path: "/catalyst/v1/smart-album/search", method: "GET", queryParameters: { q } };
  },

  createStatus(data: CatalystCreateStatusRequest): Endpoint {
    return { path: "/catalyst/v1/status", method: "POST", body: data };
  },

  getStatus(id: string): Endpoint {
    return { path: `/catalyst/v1.1/status/${id}`, method: "GET" };
  },

  editStatus(id: string, data: CatalystEditStatusRequest): Endpoint {
    return { path: `/catalyst/v1/status/${id}`, method: "PATCH", body: data };
  },

  deleteStatus(id: string): Endpoint {
    return { path: `/catalyst/v1/status/${id}`, method: "DELETE" };
  },

  isFavorited(id: string): Endpoint {
    return { path: `/catalyst/v1/status/${id}/favorite`, method: "GET" };
  },

  favorite(id: string): Endpoint {
    return { path: `/catalyst/v1/status/${id}/favorite`, method: "POST" };
  },

  unfavorite(id: string): Endpoint {
    return { path: `/catalyst/v1/status/${id}/favorite`, method: "DELETE" };
  },

  reactions(id: string): Endpoint {
    return { path: `/catalyst/v1/status/${id}/reactions`, method: "GET" };
  },

  react(id: string, symbol: string): Endpoint {
    return { path: `/catalyst/v1/status/${id}/reactions/${symbol}`, method: "POST" };
  },

  unreact(id: string, symbol: string): Endpoint {
    return { path: `/catalyst/v1/status/${id}/reactions/${symbol}`, method: "DELETE" };
  },

  contestTimeline(slug: string, opts: { since?: string; until?: string } = {}): Endpoint {
    return {
      path: `/catalyst/v1/timeline/contest/by/slug/${slug}`,
      method: "GET",
      queryParameters: buildTimelineParams(opts),
    };
  },

  favoriteTimeline(opts: { since?: string; until?: string } = {}): Endpoint {
    return {
      path: "/catalyst/v1/timeline/favorite",
      method: "GET",
      queryParameters: buildTimelineParams(opts),
    };
  },

  firehoseTimeline(opts: { since?: string; until?: string } = {}): Endpoint {
    return {
      path: "/catalyst/v1.1/timeline/firehose",
      method: "GET",
      queryParameters: buildTimelineParams(opts),
    };
  },

  galleryTimeline(opts: { since?: string; until?: string } = {}): Endpoint {
    return {
      path: "/catalyst/v1/timeline/gallery",
      method: "GET",
      queryParameters: buildTimelineParams(opts),
    };
  },

  homeTimeline(opts: { since?: string; until?: string } = {}): Endpoint {
    return {
      path: "/catalyst/v1.1/timeline/home",
      method: "GET",
      queryParameters: buildTimelineParams(opts),
    };
  },

  searchTimeline(opts: { q?: string; exact?: boolean; since?: string; until?: string } = {}): Endpoint {
    const params: Record<string, string> = {};
    if (opts.q != null) params["q"] = opts.q;
    if (opts.exact != null) params["exact"] = String(opts.exact);
    if (opts.since != null) params["since"] = opts.since;
    if (opts.until != null) params["until"] = opts.until;
    return {
      path: "/catalyst/v1/timeline/search",
      method: "GET",
      queryParameters: Object.keys(params).length > 0 ? params : undefined,
    };
  },

  userTimeline(
    username: string,
    opts: { trimUser?: boolean; excludeSensitive?: boolean; since?: string; until?: string } = {},
  ): Endpoint {
    const params: Record<string, string> = {};
    if (opts.trimUser != null) params["trim_user"] = String(opts.trimUser);
    if (opts.excludeSensitive != null) params["exclude_sensitive"] = String(opts.excludeSensitive);
    if (opts.since != null) params["since"] = opts.since;
    if (opts.until != null) params["until"] = opts.until;
    return {
      path: `/catalyst/v1/timeline/user/by/username/${username}`,
      method: "GET",
      queryParameters: Object.keys(params).length > 0 ? params : undefined,
    };
  },

  userGalleryTimeline(username: string, opts: { since?: string; until?: string } = {}): Endpoint {
    return {
      path: `/catalyst/v1/timeline/user/by/username/${username}/gallery`,
      method: "GET",
      queryParameters: buildTimelineParams(opts),
    };
  },

  trend(): Endpoint {
    return { path: "/catalyst/v1/trend", method: "GET" };
  },
} as const;
