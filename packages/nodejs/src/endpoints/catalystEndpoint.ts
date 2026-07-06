import type { Endpoint } from "./endpoint.js";
import type {
  CatalystCreateAlbumRequest,
  CatalystEditAlbumRequest,
  CatalystInsertOrRemoveStatusAlbumRequest,
  CatalystCreateSmartAlbumRequest,
  CatalystEditSmartAlbumRequest,
  CatalystCreateAlbumBookRequest,
} from "../types/albums.js";
import type {
  CatalystCreateStatusRequest,
  CatalystEditStatusRequest,
} from "../types/status.js";
import type { CatalystRelationshipRequest } from "../types/relationships.js";
import type { UpdateCustomReactionRequest } from "../types/reactions.js";
import { CatalystCreateFleetRequest } from "../types/fleet.js";
import { ReportRequest } from "../types/report.js";
import { CatalystPrivacySettingsRequest } from "../types/privacy.js";
import { UpdateProfileTagsRequest } from "../types/profileTags.js";

function buildTimelineParams(opts: {
  since?: string;
  until?: string;
}): Record<string, string> | undefined {
  const params: Record<string, string> = {};
  if (opts.since != null) params["since"] = opts.since;
  if (opts.until != null) params["until"] = opts.until;
  return Object.keys(params).length > 0 ? params : undefined;
}

export const CatalystEndpoint = {
  // Album

  createAlbum(data: CatalystCreateAlbumRequest): Endpoint {
    return { path: "/catalyst/v1/album", method: "POST", body: data };
  },

  getAlbum(
    id: string,
    opts: { limit?: number; since?: string; until?: string } = {},
  ): Endpoint {
    const params: Record<string, string> = {};
    if (opts.limit != null) params["limit"] = String(opts.limit);
    if (opts.since != null) params["since"] = opts.since;
    if (opts.until != null) params["until"] = opts.until;
    return {
      path: `/catalyst/v1/album/by/id/${id}`,
      method: "GET",
      queryParameters: Object.keys(params).length > 0 ? params : undefined,
    };
  },

  insertToAlbum(id: string, statusId: string): Endpoint {
    return {
      path: `/catalyst/v1/album/by/id/${id}`,
      method: "PUT",
      body: { insert: statusId } satisfies CatalystInsertOrRemoveStatusAlbumRequest,
    };
  },

  removeFromAlbum(id: string, statusId: string): Endpoint {
    return {
      path: `/catalyst/v1/album/by/id/${id}`,
      method: "PUT",
      body: { remove: statusId } satisfies CatalystInsertOrRemoveStatusAlbumRequest,
    };
  },

  editAlbum(id: string, data: CatalystEditAlbumRequest): Endpoint {
    return {
      path: `/catalyst/v1/album/by/id/${id}`,
      method: "PATCH",
      body: data,
    };
  },

  deleteAlbum(id: string): Endpoint {
    return { path: `/catalyst/v1/album/by/id/${id}`, method: "DELETE" };
  },

  getAlbumBooks(id: string): Endpoint {
    return { path: `/catalyst/v1/album/by/id/${id}/book`, method: "GET" };
  },

  createAlbumBook(id: string, data: CatalystCreateAlbumBookRequest): Endpoint {
    return {
      path: `/catalyst/v1/album/by/id/${id}/book`,
      method: "POST",
      body: data,
    };
  },

  getAlbumBook(id: string, bookId: string): Endpoint {
    return {
      path: `/catalyst/v1/album/by/id/${id}/book/${bookId}`,
      method: "GET",
    };
  },

  regenerateAlbumBook(id: string, bookId: string): Endpoint {
    return {
      path: `/catalyst/v1/album/by/id/${id}/book/${bookId}/regenerate`,
      method: "POST",
    };
  },

  getAlbumsByMe(includeSmartAlbums = false): Endpoint {
    return {
      path: "/catalyst/v1/album/by/me",
      method: "GET",
      queryParameters: { include_smart_albums: String(includeSmartAlbums) },
    };
  },

  listAlbums(username: string, includeSmartAlbum = true): Endpoint {
    return {
      path: `/catalyst/v1/album/by/user/${username}`,
      method: "GET",
      queryParameters: { include_smart_album: String(includeSmartAlbum) },
    };
  },

  searchAlbums(
    q?: string,
    includeSmartAlbum = true,
    until?: string,
  ): Endpoint {
    const params: Record<string, string> = {
      include_smart_album: String(includeSmartAlbum),
    };
    if (q != null) params["q"] = q;
    if (until != null) params["until"] = until;
    return { path: "/catalyst/v1/album/search", method: "GET", queryParameters: params };
  },

  // Announcements

  announcements(): Endpoint {
    return { path: "/catalyst/v1/announcements", method: "GET" };
  },

  // Blocks

  block(userId: string): Endpoint {
    return {
      path: "/catalyst/v1/blocks",
      method: "POST",
      body: { userId } satisfies CatalystRelationshipRequest,
    };
  },

  unblock(userId: string): Endpoint {
    return {
      path: "/catalyst/v1/blocks",
      method: "DELETE",
      body: { userId } satisfies CatalystRelationshipRequest,
    };
  },

  // Contest
  // NOTE: the spec only exposes read + vote operations for contests; contest management
  // (create/edit/awards/collaborators/copy/dashboard/publish/polls) is no longer part of the API.

  getContestsByMe(): Endpoint {
    return { path: "/catalyst/v1/contest/by/me", method: "GET" };
  },

  getContestBySlug(slug: string): Endpoint {
    return { path: `/catalyst/v1/contest/by/slug/${slug}`, method: "GET" };
  },

  contestTimeline(slug: string): Endpoint {
    // The spec also lists `slug` as a duplicate required query parameter here; that is a spec
    // generation quirk (no `{}` placeholder for it), so only the path parameter is wired.
    return {
      path: `/catalyst/v1/contest/by/slug/${slug}/timeline`,
      method: "GET",
    };
  },

  getContestVotes(slug: string): Endpoint {
    return { path: `/catalyst/v1/contest/by/slug/${slug}/vote`, method: "GET" };
  },

  addContestVote(slug: string, status: string): Endpoint {
    return {
      path: `/catalyst/v1/contest/by/slug/${slug}/vote/${status}`,
      method: "POST",
    };
  },

  removeContestVote(slug: string, status: string): Endpoint {
    return {
      path: `/catalyst/v1/contest/by/slug/${slug}/vote/${status}`,
      method: "DELETE",
    };
  },

  getContestsByUser(userId: string): Endpoint {
    return { path: `/catalyst/v1/contest/by/user/${userId}`, method: "GET" };
  },

  currentContests(): Endpoint {
    return { path: "/catalyst/v1/contest/current", method: "GET" };
  },

  searchContests(q?: string, state?: string, id?: string): Endpoint {
    const params: Record<string, string> = {};
    if (q != null) params["q"] = q;
    if (state != null) params["state"] = state;
    if (id != null) params["id"] = id;
    return {
      path: "/catalyst/v1/contest/search",
      method: "GET",
      queryParameters: Object.keys(params).length > 0 ? params : undefined,
    };
  },

  // Custom reactions

  customReactions(): Endpoint {
    return { path: "/catalyst/v1/reactions", method: "GET" };
  },

  getCustomUserReactions(): Endpoint {
    return { path: "/catalyst/v1/custom-reactions", method: "GET" };
  },

  createCustomReaction(data: FormData): Endpoint {
    return {
      path: "/catalyst/v1/custom-reactions",
      method: "POST",
      body: data,
    };
  },

  updateCustomReaction(
    id: string,
    data: UpdateCustomReactionRequest,
  ): Endpoint {
    return {
      path: `/catalyst/v1/custom-reactions/${id}`,
      method: "PATCH",
      body: data,
    };
  },

  deleteCustomReaction(id: string): Endpoint {
    return { path: `/catalyst/v1/custom-reactions/${id}`, method: "DELETE" };
  },

  // Fleet

  createFleet(data: CatalystCreateFleetRequest): Endpoint {
    return { path: "/catalyst/v1/fleet", method: "POST", body: data };
  },

  fleetByUsername(username: string): Endpoint {
    return { path: `/catalyst/v1/fleet/by/user/${username}`, method: "GET" };
  },

  fleets(): Endpoint {
    return { path: "/catalyst/v1/fleet/ring", method: "GET" };
  },

  fleetById(id: string): Endpoint {
    return { path: `/catalyst/v1/fleet/${id}`, method: "GET" };
  },

  deleteFleet(id: string): Endpoint {
    return { path: `/catalyst/v1/fleet/${id}`, method: "DELETE" };
  },

  reactFleet(id: string, symbol: string): Endpoint {
    return {
      path: `/catalyst/v1/fleet/${id}/reactions/${symbol}`,
      method: "POST",
    };
  },

  unreactFleet(id: string, symbol: string): Endpoint {
    return {
      path: `/catalyst/v1/fleet/${id}/reactions/${symbol}`,
      method: "DELETE",
    };
  },

  viewFleet(id: string): Endpoint {
    return { path: `/catalyst/v1/fleet/${id}/view`, method: "POST" };
  },

  fleetViewers(id: string): Endpoint {
    return { path: `/catalyst/v1/fleet/${id}/viewers`, method: "GET" };
  },

  // Privacy

  getPrivacySettings(): Endpoint {
    return { path: "/catalyst/v1/privacy/settings", method: "GET" };
  },

  updatePrivacySettings(data: CatalystPrivacySettingsRequest): Endpoint {
    return {
      path: "/catalyst/v1/privacy/settings",
      method: "PATCH",
      body: data,
    };
  },

  // Profile tags

  updateProfileTags(data: UpdateProfileTagsRequest): Endpoint {
    return { path: "/catalyst/v1/profile-tags", method: "PUT", body: data };
  },

  profileTagSuggestions(q: string): Endpoint {
    return {
      path: "/catalyst/v1/profile-tags/suggestions",
      method: "GET",
      queryParameters: { q },
    };
  },

  getUsersByProfileTag(name: string, cursor?: string): Endpoint {
    return {
      path: `/catalyst/v1/profile-tags/by/name/${name}/users`,
      method: "GET",
      queryParameters: cursor != null ? { cursor } : undefined,
    };
  },

  getProfileTagsByUser(id: string): Endpoint {
    return { path: `/catalyst/v1/profile-tags/by/user/${id}`, method: "GET" };
  },

  // Random

  randomStatus(): Endpoint {
    return { path: "/catalyst/v1/random", method: "GET" };
  },

  randomStatusV1_1(): Endpoint {
    return { path: "/catalyst/v1.1/random", method: "GET" };
  },

  onThisDay(): Endpoint {
    return { path: "/catalyst/v1.1/on-this-day", method: "GET" };
  },

  // Status

  createStatus(data: CatalystCreateStatusRequest): Endpoint {
    return { path: "/catalyst/v1/status", method: "POST", body: data };
  },

  getStatus(id: string): Endpoint {
    return { path: `/catalyst/v1/status/${id}`, method: "GET" };
  },

  getStatusV1_1(id: string): Endpoint {
    return { path: `/catalyst/v1.1/status/${id}`, method: "GET" };
  },

  editStatus(id: string, data: CatalystEditStatusRequest): Endpoint {
    return { path: `/catalyst/v1/status/${id}`, method: "PATCH", body: data };
  },

  deleteStatus(id: string): Endpoint {
    return { path: `/catalyst/v1/status/${id}`, method: "DELETE" };
  },

  albumsInStatus(id: string): Endpoint {
    return { path: `/catalyst/v1/status/${id}/albums`, method: "GET" };
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

  reactWithCustomReaction(id: string, customReactionId: string): Endpoint {
    return {
      path: `/catalyst/v1/status/${id}/reactions/custom/${customReactionId}`,
      method: "POST",
    };
  },

  unreactWithCustomReaction(id: string, customReactionId: string): Endpoint {
    return {
      path: `/catalyst/v1/status/${id}/reactions/custom/${customReactionId}`,
      method: "DELETE",
    };
  },

  react(id: string, symbol: string): Endpoint {
    return {
      path: `/catalyst/v1/status/${id}/reactions/${symbol}`,
      method: "POST",
    };
  },

  unreact(id: string, symbol: string): Endpoint {
    return {
      path: `/catalyst/v1/status/${id}/reactions/${symbol}`,
      method: "DELETE",
    };
  },

  reportStatus(id: string, data: ReportRequest): Endpoint {
    return {
      path: `/catalyst/v1/status/${id}/report`,
      method: "POST",
      body: data,
    };
  },

  // Bulk status reactions

  bulkStatusReactions(ids: string[]): Endpoint {
    return {
      path: "/catalyst/v1/statuses/reactions",
      method: "POST",
      body: { ids },
    };
  },

  // Relationships

  follow(userId: string): Endpoint {
    return {
      path: "/catalyst/v1/relationships",
      method: "POST",
      body: { userId } satisfies CatalystRelationshipRequest,
    };
  },

  remove(userId: string): Endpoint {
    return {
      path: "/catalyst/v1/relationships",
      method: "DELETE",
      body: { userId } satisfies CatalystRelationshipRequest,
    };
  },

  relationshipCounts(username: string): Endpoint {
    return {
      path: `/catalyst/v1/relationships/by/username/${username}/counts`,
      method: "GET",
    };
  },

  followers(username: string, opts?: { page?: number }): Endpoint {
    return {
      path: `/catalyst/v1/relationships/by/username/${username}/followers`,
      method: "GET",
      queryParameters:
        opts?.page != null ? { page: String(opts.page) } : undefined,
    };
  },

  followings(username: string, opts?: { page?: number }): Endpoint {
    return {
      path: `/catalyst/v1/relationships/by/username/${username}/followings`,
      method: "GET",
      queryParameters:
        opts?.page != null ? { page: String(opts.page) } : undefined,
    };
  },

  relationships(id: string): Endpoint {
    return { path: `/catalyst/v1/relationships/${id}`, method: "GET" };
  },

  // Smart album

  createSmartAlbum(data: CatalystCreateSmartAlbumRequest): Endpoint {
    return { path: "/catalyst/v1/smart-album", method: "POST", body: data };
  },

  getSmartAlbum(
    id: string,
    opts: { limit?: number; since?: string; until?: string } = {},
  ): Endpoint {
    const params: Record<string, string> = {};
    if (opts.limit != null) params["limit"] = String(opts.limit);
    if (opts.since != null) params["since"] = opts.since;
    if (opts.until != null) params["until"] = opts.until;
    return {
      path: `/catalyst/v1/smart-album/by/id/${id}`,
      method: "GET",
      queryParameters: Object.keys(params).length > 0 ? params : undefined,
    };
  },

  editSmartAlbum(id: string, data: CatalystEditSmartAlbumRequest): Endpoint {
    return {
      path: `/catalyst/v1/smart-album/by/id/${id}`,
      method: "PATCH",
      body: data,
    };
  },

  deleteSmartAlbum(id: string): Endpoint {
    return { path: `/catalyst/v1/smart-album/by/id/${id}`, method: "DELETE" };
  },

  getSmartAlbumBooks(id: string): Endpoint {
    return { path: `/catalyst/v1/smart-album/by/id/${id}/book`, method: "GET" };
  },

  createSmartAlbumBook(id: string, data: CatalystCreateAlbumBookRequest): Endpoint {
    return {
      path: `/catalyst/v1/smart-album/by/id/${id}/book`,
      method: "POST",
      body: data,
    };
  },

  getSmartAlbumBook(id: string, bookId: string): Endpoint {
    return {
      path: `/catalyst/v1/smart-album/by/id/${id}/book/${bookId}`,
      method: "GET",
    };
  },

  regenerateSmartAlbumBook(id: string, bookId: string): Endpoint {
    return {
      path: `/catalyst/v1/smart-album/by/id/${id}/book/${bookId}/regenerate`,
      method: "POST",
    };
  },

  listSmartAlbumsByUser(userId: string): Endpoint {
    return { path: `/catalyst/v1/smart-album/by/user/${userId}`, method: "GET" };
  },

  searchSmartAlbums(q?: string): Endpoint {
    return {
      path: "/catalyst/v1/smart-album/search",
      method: "GET",
      queryParameters: q != null ? { q } : undefined,
    };
  },

  // Timelines

  archiveTimeline(opts: {
    year: number;
    month: number;
    day?: number;
    since?: string;
    until?: string;
    userId?: string;
    limit?: number;
    excludeSensitive?: boolean;
  }): Endpoint {
    const params: Record<string, string> = {
      year: String(opts.year),
      month: String(opts.month),
    };
    if (opts.day != null) params["day"] = String(opts.day);
    if (opts.since != null) params["since"] = opts.since;
    if (opts.until != null) params["until"] = opts.until;
    if (opts.userId != null) params["userId"] = opts.userId;
    if (opts.limit != null) params["limit"] = String(opts.limit);
    if (opts.excludeSensitive != null)
      params["excludeSensitive"] = String(opts.excludeSensitive);
    return {
      path: "/catalyst/v1/timeline/archive",
      method: "GET",
      queryParameters: params,
    };
  },

  archiveMonths(): Endpoint {
    return { path: "/catalyst/v1/timeline/archive/months", method: "GET" };
  },

  timelineByContestSlug(
    slug: string,
    opts: { since?: string; until?: string } = {},
  ): Endpoint {
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

  firehoseTimelineV1(opts: { since?: string; until?: string } = {}): Endpoint {
    // The spec lists since/until as `in: path` here despite no `{}` placeholder in the path;
    // this is a spec generation quirk, so they are sent as query parameters.
    return {
      path: "/catalyst/v1/timeline/firehose",
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

  homeTimelineV1(): Endpoint {
    return { path: "/catalyst/v1/timeline/home", method: "GET" };
  },

  searchTimeline(
    opts: { q?: string; exact?: boolean; since?: string; until?: string } = {},
  ): Endpoint {
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
    opts: {
      since?: string;
      until?: string;
      limit?: number;
      excludeSensitive?: boolean;
    } = {},
  ): Endpoint {
    const params: Record<string, string> = {};
    if (opts.since != null) params["since"] = opts.since;
    if (opts.until != null) params["until"] = opts.until;
    if (opts.limit != null) params["limit"] = String(opts.limit);
    if (opts.excludeSensitive != null)
      params["exclude_sensitive"] = String(opts.excludeSensitive);
    return {
      path: `/catalyst/v1/timeline/user/by/username/${username}`,
      method: "GET",
      queryParameters: Object.keys(params).length > 0 ? params : undefined,
    };
  },

  userGalleryTimeline(
    username: string,
    opts: { since?: string; until?: string } = {},
  ): Endpoint {
    return {
      path: `/catalyst/v1/timeline/user/by/username/${username}/gallery`,
      method: "GET",
      queryParameters: buildTimelineParams(opts),
    };
  },

  firehoseTimeline(
    opts: { since?: string; until?: string; trimVisitor?: boolean } = {},
  ): Endpoint {
    const params: Record<string, string> = {};
    if (opts.since != null) params["since"] = opts.since;
    if (opts.until != null) params["until"] = opts.until;
    if (opts.trimVisitor != null) params["trim_visitor"] = String(opts.trimVisitor);
    return {
      path: "/catalyst/v1.1/timeline/firehose",
      method: "GET",
      queryParameters: Object.keys(params).length > 0 ? params : undefined,
    };
  },

  homeTimeline(
    opts: { since?: string; until?: string; trimVisitor?: boolean } = {},
  ): Endpoint {
    const params: Record<string, string> = {};
    if (opts.since != null) params["since"] = opts.since;
    if (opts.until != null) params["until"] = opts.until;
    if (opts.trimVisitor != null) params["trim_visitor"] = String(opts.trimVisitor);
    return {
      path: "/catalyst/v1.1/timeline/home",
      method: "GET",
      queryParameters: Object.keys(params).length > 0 ? params : undefined,
    };
  },

  // Trend

  trend(): Endpoint {
    return { path: "/catalyst/v1/trend", method: "GET" };
  },

  richTrend(): Endpoint {
    return {
      path: "/catalyst/v1/trend",
      method: "GET",
      queryParameters: { format: "rich" },
    };
  },
} as const;
