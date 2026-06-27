import type { Endpoint } from "./endpoint.js";
import type {
  CatalystCreateAlbumRequest,
  CatalystEditAlbumRequest,
  CatalystInsertToAlbumRequest,
  CatalystRemoveFromAlbumRequest,
  CatalystCreateSmartAlbumRequest,
  CatalystEditSmartAlbumRequest,
} from "../types/albums.js";
import type {
  CatalystCreateStatusRequest,
  CatalystEditStatusRequest,
} from "../types/status.js";
import type { CatalystRelationshipRequest } from "../types/relationships.js";
import type {
  CreateCustomReactionRequest,
  UpdateCustomReactionRequest,
} from "../types/reactions.js";
import { CatalystCreateFleetRequest } from "../types/fleet.js";
import {
  CatalystContestAddCollaboratorRequest,
  CatalystContestRemoveCollaboratorRequest,
  CatalystCreateContestRequest,
  CatalystEditContestRequest,
  CatalystSetContestAwardRequest,
  CatalystUnsetContestAwardRequest,
} from "../types/contest.js";
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
  createAlbum(data: CatalystCreateAlbumRequest): Endpoint {
    return { path: "/catalyst/v1/album", method: "POST", body: data };
  },

  getAlbum(
    id: string,
    opts: { since?: string; until?: string } = {},
  ): Endpoint {
    return {
      path: `/catalyst/v1/album/by/id/${id}`,
      method: "GET",
      queryParameters: buildTimelineParams(opts),
    };
  },

  editAlbum(id: string, data: CatalystEditAlbumRequest): Endpoint {
    return {
      path: `/catalyst/v1/album/by/id/${id}`,
      method: "PATCH",
      body: data,
    };
  },

  insertToAlbum(id: string, data: CatalystInsertToAlbumRequest): Endpoint {
    return {
      path: `/catalyst/v1/album/by/id/${id}`,
      method: "PUT",
      body: data,
    };
  },

  removeFromAlbum(id: string, data: CatalystRemoveFromAlbumRequest): Endpoint {
    return {
      path: `/catalyst/v1/album/by/id/${id}`,
      method: "PUT",
      body: data,
    };
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

  customUserReactions(): Endpoint {
    return { path: "/catalyst/v1/custom-reactions", method: "GET" };
  },

  createCustomReaction(data: CreateCustomReactionRequest): Endpoint {
    return { path: "/catalyst/v1/custom-reactions", method: "POST", body: data };
  },

  updateCustomReaction(id: string, data: UpdateCustomReactionRequest): Endpoint {
    return {
      path: `/catalyst/v1/custom-reactions/${id}`,
      method: "PATCH",
      body: data,
    };
  },

  deleteCustomReaction(id: string): Endpoint {
    return { path: `/catalyst/v1/custom-reactions/${id}`, method: "DELETE" };
  },

  block(data: CatalystRelationshipRequest): Endpoint {
    return {
      path: "/catalyst/v1/blocks",
      method: "POST",
      body: data,
    };
  },

  unblock(data: CatalystRelationshipRequest): Endpoint {
    return {
      path: "/catalyst/v1/blocks",
      method: "DELETE",
      body: data,
    };
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

  followings(username: string, opts?: { page?: number }): Endpoint {
    return {
      path: `/catalyst/v1/relationships/by/username/${username}/followings`,
      method: "GET",
      queryParameters:
        opts?.page != null ? { page: String(opts.page) } : undefined,
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

  relationshipCounts(username: string): Endpoint {
    return {
      path: `/catalyst/v1/relationships/by/username/${username}/counts`,
      method: "GET",
    };
  },

  createSmartAlbum(data: CatalystCreateSmartAlbumRequest): Endpoint {
    return { path: "/catalyst/v1/smart-album", method: "POST", body: data };
  },

  getSmartAlbum(
    id: string,
    opts: { since?: string; until?: string } = {},
  ): Endpoint {
    return {
      path: `/catalyst/v1/smart-album/by/id/${id}`,
      method: "GET",
      queryParameters: buildTimelineParams(opts),
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

  searchSmartAlbum(q: string): Endpoint {
    return {
      path: "/catalyst/v1/smart-album/search",
      method: "GET",
      queryParameters: { q },
    };
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

  albumsInStatus(id: string): Endpoint {
    return { path: `/catalyst/v1/status/${id}/albums`, method: "GET" };
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

  contestTimeline(
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
      trimUser?: boolean;
      excludeSensitive?: boolean;
      since?: string;
      until?: string;
    } = {},
  ): Endpoint {
    const params: Record<string, string> = {};
    if (opts.trimUser != null) params["trim_user"] = String(opts.trimUser);
    if (opts.excludeSensitive != null)
      params["exclude_sensitive"] = String(opts.excludeSensitive);
    if (opts.since != null) params["since"] = opts.since;
    if (opts.until != null) params["until"] = opts.until;
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

  trend(): Endpoint {
    return { path: "/catalyst/v1/trend", method: "GET" };
  },

  createFleet(data: CatalystCreateFleetRequest): Endpoint {
    return {
      path: "/catalyst/v1/fleet",
      method: "POST",
      body: data,
    };
  },

  fleetById(id: string): Endpoint {
    return {
      path: `/catalyst/v1/fleet/${id}`,
      method: "GET",
    };
  },

  deleteFleet(id: string): Endpoint {
    return {
      path: `/catalyst/v1/fleet/${id}`,
      method: "DELETE",
    };
  },

  viewFleet(id: string): Endpoint {
    return {
      path: `/catalyst/v1/fleet/${id}/view`,
      method: "POST",
    };
  },

  fleetViewers(id: string): Endpoint {
    return {
      path: `/catalyst/v1/fleet/${id}/viewers`,
      method: "GET",
    };
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

  fleets(): Endpoint {
    return {
      path: "/catalyst/v1/fleet/ring",
      method: "GET",
    };
  },

  fleetByUsername(username: string): Endpoint {
    return {
      path: `/catalyst/v1/fleet/by/user/${username}`,
      method: "GET",
    };
  },

  createContest(data: CatalystCreateContestRequest): Endpoint {
    return {
      path: "/catalyst/v1/contest",
      method: "POST",
      body: data,
    };
  },

  getContestsByMe(): Endpoint {
    return {
      path: "/catalyst/v1/contest/by/me",
      method: "GET",
    };
  },

  getContestBySlug(slug: string): Endpoint {
    return {
      path: `/catalyst/v1/contest/by/slug/${slug}`,
      method: "GET",
    };
  },

  editContest(slug: string, data: CatalystEditContestRequest): Endpoint {
    return {
      path: `/catalyst/v1/contest/by/slug/${slug}`,
      method: "PATCH",
      body: data,
    };
  },

  getContestAwards(slug: string): Endpoint {
    return {
      path: `/catalyst/v1/contest/by/slug/${slug}/awards`,
      method: "GET",
    };
  },

  setContestAward(
    slug: string,
    id: string,
    data: CatalystSetContestAwardRequest,
  ): Endpoint {
    return {
      path: `/catalyst/v1/contest/by/slug/${slug}/awards/${id}`,
      method: "POST",
      body: data,
    };
  },

  unsetContestAward(
    slug: string,
    id: string,
    data: CatalystUnsetContestAwardRequest,
  ): Endpoint {
    return {
      path: `/catalyst/v1/contest/by/slug/${slug}/awards/${id}`,
      method: "DELETE",
      body: data,
    };
  },

  getContestCollaborators(slug: string): Endpoint {
    return {
      path: `/catalyst/v1/contest/by/slug/${slug}/collaborators`,
      method: "GET",
    };
  },

  addContestCollaborator(
    slug: string,
    data: CatalystContestAddCollaboratorRequest,
  ): Endpoint {
    return {
      path: `/catalyst/v1/contest/by/slug/${slug}/collaborators`,
      method: "POST",
      body: data,
    };
  },

  removeContestCollaborator(
    slug: string,
    data: CatalystContestRemoveCollaboratorRequest,
  ): Endpoint {
    return {
      path: `/catalyst/v1/contest/by/slug/${slug}/collaborators`,
      method: "DELETE",
      body: data,
    };
  },

  copyContest(slug: string): Endpoint {
    return {
      path: `/catalyst/v1/contest/by/slug/${slug}/copy`,
      method: "POST",
    };
  },

  getAccessPermissionOfContest(slug: string): Endpoint {
    return {
      path: `/catalyst/v1/contest/by/slug/${slug}/dashboard`,
      method: "GET",
    };
  },

  getContestPolls(slug: string): Endpoint {
    return {
      path: `/catalyst/v1/contest/by/slug/${slug}/polls`,
      method: "GET",
    };
  },

  publishContest(slug: string): Endpoint {
    return {
      path: `/catalyst/v1/contest/by/slug/${slug}/publish`,
      method: "POST",
    };
  },

  addContestVoteToStatus(slug: string, id: string): Endpoint {
    return {
      path: `/catalyst/v1/contest/by/slug/${slug}/vote/${id}`,
      method: "POST",
    };
  },

  removeContestVoteFromStatus(slug: string, id: string): Endpoint {
    return {
      path: `/catalyst/v1/contest/by/slug/${slug}/vote/${id}`,
      method: "DELETE",
    };
  },

  getContestVotes(slug: string): Endpoint {
    return {
      path: `/catalyst/v1/contest/by/slug/${slug}/votes`,
      method: "GET",
    };
  },

  searchContest(state: string, q?: string): Endpoint {
    return {
      path: "/catalyst/v1/contest/search",
      method: "GET",
      queryParameters: { state, q: q ?? "" },
    };
  },

  reportStatus(id: string, data: ReportRequest): Endpoint {
    return {
      path: `/catalyst/v1/status/${id}/report`,
      method: "POST",
      body: data,
    };
  },

  getPrivacySettings(): Endpoint {
    return {
      path: "/catalyst/v1/privacy/settings",
      method: "GET",
    };
  },

  updatePrivacySettings(data: CatalystPrivacySettingsRequest): Endpoint {
    return {
      path: "/catalyst/v1/privacy/settings",
      method: "PATCH",
      body: data,
    };
  },

  // Announcements

  announcements(): Endpoint {
    return { path: "/catalyst/v1/announcements", method: "GET" };
  },

  // Profile Tags

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
    return {
      path: `/catalyst/v1/profile-tags/by/user/${id}`,
      method: "GET",
    };
  },

  // Random

  randomStatus(): Endpoint {
    return { path: "/catalyst/v1/random", method: "GET" };
  },

  randomStatusByHashtag(q: string): Endpoint {
    return {
      path: "/catalyst/v1/random/by/hashtag",
      method: "GET",
      queryParameters: { q },
    };
  },

  // Bulk reactions

  bulkStatusReactions(ids: string[]): Endpoint {
    return {
      path: "/catalyst/v1/statuses/reactions",
      method: "POST",
      body: { ids },
    };
  },

  // Archive timeline

  archiveTimeline(opts: {
    year: number;
    month: number;
    day?: number;
    since?: string;
    until?: string;
    userId?: string;
    limit?: number;
    trimUser?: boolean;
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
    if (opts.trimUser != null) params["trimUser"] = String(opts.trimUser);
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

  // Contests

  currentContests(): Endpoint {
    return { path: "/catalyst/v1/contest/current", method: "GET" };
  },

  getContestsByUser(username: string): Endpoint {
    return {
      path: `/catalyst/v1/contest/by/user/${username}`,
      method: "GET",
    };
  },

  // Album by me

  getAlbumsByMe(includeSmartAlbums = false): Endpoint {
    return {
      path: "/catalyst/v1/album/by/me",
      method: "GET",
      queryParameters: { include_smart_albums: String(includeSmartAlbums) },
    };
  },

  // Smart album by user

  listSmartAlbumsByUser(username: string): Endpoint {
    return {
      path: `/catalyst/v1/smart-album/by/user/${username}`,
      method: "GET",
    };
  },

} as const;
