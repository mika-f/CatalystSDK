import { CatalystEndpoint } from "../endpoints/catalystEndpoint.js";
import type { HttpClient } from "./httpClient.js";
import type { Identity } from "../types/identity.js";
import type {
  CatalystAlbum,
  CatalystSmartAlbum,
  CatalystSmartAlbums,
  CatalystCreateAlbumRequest,
  CatalystEditAlbumRequest,
  CatalystInsertToAlbumRequest,
  CatalystRemoveFromAlbumRequest,
  CatalystCreateSmartAlbumRequest,
  CatalystEditSmartAlbumRequest,
} from "../types/albums.js";
import type {
  CatalystStatus,
  CatalystStatusV1_1,
  CatalystStatusWrapper,
  CatalystStatuses,
  CatalystCreateStatusRequest,
  CatalystEditStatusRequest,
} from "../types/status.js";
import type {
  CatalystReactions,
  CatalystCustomReaction,
  CatalystCustomReactionList,
  CatalystUserCustomReaction,
  UpdateCustomReactionRequest,
} from "../types/reactions.js";
import type {
  CatalystRelationships,
  CatalystRelationshipRequest,
} from "../types/relationships.js";
import {
  CatalystCreateFleetRequest,
  CatalystFleet,
  CatalystFleetRing,
  CatalystFleetViewer,
} from "../types/fleet.js";
import {
  CatalystContest,
  CatalystContestAddCollaboratorRequest,
  CatalystContestAward,
  CatalystContestCollaborator,
  CatalystContestRemoveCollaboratorRequest,
  CatalystCreateContestRequest,
  CatalystEditContestRequest,
  CatalystSetContestAwardRequest,
  CatalystUnsetContestAwardRequest,
  CatalystUserVoteRights,
} from "../types/contest.js";
import { ReportRequest } from "../types/report.js";
import { EgeriaUser } from "../types/users.js";
import {
  CatalystPrivacySettings,
  CatalystPrivacySettingsRequest,
} from "../types/privacy.js";
import { CatalystAnnouncement } from "../types/announcements.js";
import {
  ProfileTag,
  ProfileTagSuggestion,
  ProfileTagUser,
  UpdateProfileTagsRequest,
} from "../types/profileTags.js";

export class CatalystClient {
  constructor(private readonly http: HttpClient) {}

  // Albums

  createAlbum(data: CatalystCreateAlbumRequest): Promise<Identity> {
    return this.http.request(CatalystEndpoint.createAlbum(data));
  }

  getAlbum(
    id: string,
    opts: { since?: string; until?: string } = {},
  ): Promise<CatalystAlbum> {
    return this.http.request(CatalystEndpoint.getAlbum(id, opts));
  }

  editAlbum(id: string, data: CatalystEditAlbumRequest): Promise<void> {
    return this.http.requestVoid(CatalystEndpoint.editAlbum(id, data));
  }

  insertToAlbum(id: string, data: CatalystInsertToAlbumRequest): Promise<void> {
    return this.http.requestVoid(CatalystEndpoint.insertToAlbum(id, data));
  }

  removeFromAlbum(
    id: string,
    data: CatalystRemoveFromAlbumRequest,
  ): Promise<void> {
    return this.http.requestVoid(CatalystEndpoint.removeFromAlbum(id, data));
  }

  deleteAlbum(id: string): Promise<void> {
    return this.http.requestVoid(CatalystEndpoint.deleteAlbum(id));
  }

  listAlbums(
    username: string,
    includeSmartAlbums = true,
  ): Promise<CatalystSmartAlbums> {
    return this.http.request(
      CatalystEndpoint.listAlbums(username, includeSmartAlbums),
    );
  }

  searchAlbums(
    q: string,
    includeSmartAlbums = true,
  ): Promise<CatalystSmartAlbums> {
    return this.http.request(
      CatalystEndpoint.searchAlbum(q, includeSmartAlbums),
    );
  }

  // Reactions

  customReactions(): Promise<CatalystCustomReaction[]> {
    return this.http.request(CatalystEndpoint.customReactions());
  }

  customUserReactions(): Promise<CatalystCustomReactionList> {
    return this.http.request(CatalystEndpoint.customUserReactions());
  }

  createCustomReaction(data: FormData): Promise<CatalystUserCustomReaction> {
    return this.http.request(CatalystEndpoint.createCustomReaction(data));
  }

  updateCustomReaction(id: string, data: UpdateCustomReactionRequest): Promise<void> {
    return this.http.requestVoid(CatalystEndpoint.updateCustomReaction(id, data));
  }

  deleteCustomReaction(id: string): Promise<void> {
    return this.http.requestVoid(CatalystEndpoint.deleteCustomReaction(id));
  }

  // Relationships

  block(data: CatalystRelationshipRequest): Promise<void> {
    return this.http.requestVoid(CatalystEndpoint.block(data));
  }

  unblock(data: CatalystRelationshipRequest): Promise<void> {
    return this.http.requestVoid(CatalystEndpoint.unblock(data));
  }

  relationships(id: string): Promise<CatalystRelationships> {
    return this.http.request(CatalystEndpoint.relationships(id));
  }

  follow(data: CatalystRelationshipRequest): Promise<void> {
    return this.http.requestVoid(CatalystEndpoint.follow(data));
  }

  remove(data: CatalystRelationshipRequest): Promise<void> {
    return this.http.requestVoid(CatalystEndpoint.remove(data));
  }

  followings(
    id: string,
    opts?: { page?: number },
  ): Promise<{
    items: EgeriaUser[];
    count: { total: number; offset: number };
    page: {
      min: number;
      max: number;
      current: number;
      next: number | null;
      prev: number | null;
    };
  }> {
    return this.http.request(CatalystEndpoint.followings(id, opts));
  }

  followers(
    id: string,
    opts?: { page?: number },
  ): Promise<{
    items: EgeriaUser[];
    count: { total: number; offset: number };
    page: {
      min: number;
      max: number;
      current: number;
      next: number | null;
      prev: number | null;
    };
  }> {
    return this.http.request(CatalystEndpoint.followers(id, opts));
  }

  relationshipCounts(
    id: string,
  ): Promise<{ followers: number | null; followings: number | null }> {
    return this.http.request(CatalystEndpoint.relationshipCounts(id));
  }

  // Smart Albums

  createSmartAlbum(data: CatalystCreateSmartAlbumRequest): Promise<Identity> {
    return this.http.request(CatalystEndpoint.createSmartAlbum(data));
  }

  getSmartAlbum(
    id: string,
    opts: { since?: string; until?: string } = {},
  ): Promise<CatalystSmartAlbum> {
    return this.http.request(CatalystEndpoint.getSmartAlbum(id, opts));
  }

  editSmartAlbum(
    id: string,
    data: CatalystEditSmartAlbumRequest,
  ): Promise<void> {
    return this.http.requestVoid(CatalystEndpoint.editSmartAlbum(id, data));
  }

  deleteSmartAlbum(id: string): Promise<void> {
    return this.http.requestVoid(CatalystEndpoint.deleteSmartAlbum(id));
  }

  searchSmartAlbum(q: string): Promise<CatalystSmartAlbums> {
    return this.http.request(CatalystEndpoint.searchSmartAlbum(q));
  }

  // Statuses

  createStatus(data: CatalystCreateStatusRequest): Promise<Identity> {
    return this.http.request(CatalystEndpoint.createStatus(data));
  }

  getStatus(id: string): Promise<CatalystStatusWrapper> {
    return this.http.request(CatalystEndpoint.getStatus(id));
  }

  editStatus(id: string, data: CatalystEditStatusRequest): Promise<void> {
    return this.http.requestVoid(CatalystEndpoint.editStatus(id, data));
  }

  deleteStatus(id: string): Promise<void> {
    return this.http.requestVoid(CatalystEndpoint.deleteStatus(id));
  }

  isFavorited(id: string): Promise<boolean> {
    return this.http.request(CatalystEndpoint.isFavorited(id));
  }

  favorite(id: string): Promise<void> {
    return this.http.requestVoid(CatalystEndpoint.favorite(id));
  }

  unfavorite(id: string): Promise<void> {
    return this.http.requestVoid(CatalystEndpoint.unfavorite(id));
  }

  reactions(id: string): Promise<CatalystReactions> {
    return this.http.request(CatalystEndpoint.reactions(id));
  }

  albumsInStatus(id: string): Promise<CatalystSmartAlbums> {
    return this.http.request(CatalystEndpoint.albumsInStatus(id));
  }

  react(id: string, symbol: string): Promise<void> {
    return this.http.requestVoid(CatalystEndpoint.react(id, symbol));
  }

  unreact(id: string, symbol: string): Promise<void> {
    return this.http.requestVoid(CatalystEndpoint.unreact(id, symbol));
  }

  // Timelines

  contestTimeline(
    slug: string,
    opts: { since?: string; until?: string } = {},
  ): Promise<CatalystStatuses> {
    return this.http.request(CatalystEndpoint.contestTimeline(slug, opts));
  }

  favoriteTimeline(
    opts: { since?: string; until?: string } = {},
  ): Promise<CatalystStatuses> {
    return this.http.request(CatalystEndpoint.favoriteTimeline(opts));
  }

  firehoseTimeline(
    opts: { since?: string; until?: string } = {},
  ): Promise<CatalystStatusV1_1[]> {
    return this.http.request(CatalystEndpoint.firehoseTimeline(opts));
  }

  galleryTimeline(
    opts: { since?: string; until?: string } = {},
  ): Promise<CatalystStatuses> {
    return this.http.request(CatalystEndpoint.galleryTimeline(opts));
  }

  homeTimeline(
    opts: { since?: string; until?: string } = {},
  ): Promise<CatalystStatusV1_1[]> {
    return this.http.request(CatalystEndpoint.homeTimeline(opts));
  }

  searchTimeline(
    opts: { q?: string; exact?: boolean; since?: string; until?: string } = {},
  ): Promise<CatalystStatuses> {
    return this.http.request(CatalystEndpoint.searchTimeline(opts));
  }

  userTimeline(
    username: string,
    opts: {
      trimUser?: boolean;
      excludeSensitive?: boolean;
      since?: string;
      until?: string;
    } = {},
  ): Promise<CatalystStatuses> {
    return this.http.request(CatalystEndpoint.userTimeline(username, opts));
  }

  userGalleryTimeline(
    username: string,
    opts: { since?: string; until?: string } = {},
  ): Promise<CatalystStatuses> {
    return this.http.request(
      CatalystEndpoint.userGalleryTimeline(username, opts),
    );
  }

  trend(): Promise<string[]> {
    return this.http.request(CatalystEndpoint.trend());
  }

  createFleet(data: CatalystCreateFleetRequest): Promise<void> {
    return this.http.requestVoid(CatalystEndpoint.createFleet(data));
  }

  fleetById(id: string): Promise<CatalystFleet> {
    return this.http.request(CatalystEndpoint.fleetById(id));
  }

  deleteFleet(id: string): Promise<void> {
    return this.http.requestVoid(CatalystEndpoint.deleteFleet(id));
  }

  viewFleet(id: string): Promise<void> {
    return this.http.requestVoid(CatalystEndpoint.viewFleet(id));
  }

  fleetViewers(id: string): Promise<CatalystFleetViewer[]> {
    return this.http.request(CatalystEndpoint.fleetViewers(id));
  }

  reactFleet(id: string, symbol: string): Promise<void> {
    return this.http.requestVoid(CatalystEndpoint.reactFleet(id, symbol));
  }

  unreactFleet(id: string, symbol: string): Promise<void> {
    return this.http.requestVoid(CatalystEndpoint.unreactFleet(id, symbol));
  }

  fleets(): Promise<CatalystFleetRing[]> {
    return this.http.request(CatalystEndpoint.fleets());
  }

  fleetByUsername(username: string): Promise<CatalystFleet[]> {
    return this.http.request(CatalystEndpoint.fleetByUsername(username));
  }

  createContest(data: CatalystCreateContestRequest): Promise<Identity> {
    return this.http.request(CatalystEndpoint.createContest(data));
  }

  getContestsByMe(): Promise<CatalystContest[]> {
    return this.http.request(CatalystEndpoint.getContestsByMe());
  }

  getContestBySlug(slug: string): Promise<{ contest: CatalystContest }> {
    return this.http.request(CatalystEndpoint.getContestBySlug(slug));
  }

  editContest(slug: string, data: CatalystEditContestRequest): Promise<void> {
    return this.http.requestVoid(CatalystEndpoint.editContest(slug, data));
  }

  getContestAwards(slug: string): Promise<{ awards: CatalystContestAward[] }> {
    return this.http.request(CatalystEndpoint.getContestAwards(slug));
  }

  setContestAward(
    slug: string,
    id: string,
    data: CatalystSetContestAwardRequest,
  ): Promise<void> {
    return this.http.requestVoid(
      CatalystEndpoint.setContestAward(slug, id, data),
    );
  }

  unsetContestAward(
    slug: string,
    id: string,
    data: CatalystUnsetContestAwardRequest,
  ): Promise<void> {
    return this.http.requestVoid(
      CatalystEndpoint.unsetContestAward(slug, id, data),
    );
  }

  getContestCollaborators(
    slug: string,
  ): Promise<{ collaborators: CatalystContestCollaborator[] }> {
    return this.http.request(CatalystEndpoint.getContestCollaborators(slug));
  }

  addContestCollaborator(
    slug: string,
    data: CatalystContestAddCollaboratorRequest,
  ): Promise<void> {
    return this.http.requestVoid(
      CatalystEndpoint.addContestCollaborator(slug, data),
    );
  }

  removeContestCollaborator(
    slug: string,
    data: CatalystContestRemoveCollaboratorRequest,
  ): Promise<void> {
    return this.http.requestVoid(
      CatalystEndpoint.removeContestCollaborator(slug, data),
    );
  }

  copyContest(slug: string): Promise<Identity> {
    return this.http.request(CatalystEndpoint.copyContest(slug));
  }

  getAccessPermissionOfContest(slug: string): Promise<{
    result: "admin" | "collaborator" | "contributor" | "guest";
  }> {
    return this.http.request(
      CatalystEndpoint.getAccessPermissionOfContest(slug),
    );
  }

  publishContest(slug: string): Promise<Identity> {
    return this.http.request(CatalystEndpoint.publishContest(slug));
  }

  addContestVoteToStatus(slug: string, id: string): Promise<void> {
    return this.http.requestVoid(
      CatalystEndpoint.addContestVoteToStatus(slug, id),
    );
  }

  removeContestVoteFromStatus(slug: string, id: string): Promise<void> {
    return this.http.requestVoid(
      CatalystEndpoint.removeContestVoteFromStatus(slug, id),
    );
  }

  getContestVotes(slug: string): Promise<CatalystUserVoteRights> {
    return this.http.request(CatalystEndpoint.getContestVotes(slug));
  }

  searchContest(
    state: string,
    q?: string,
  ): Promise<{ contests: CatalystContest[] }> {
    return this.http.request(CatalystEndpoint.searchContest(state, q));
  }

  // report
  reportStatus(id: string, data: ReportRequest): Promise<void> {
    return this.http.requestVoid(CatalystEndpoint.reportStatus(id, data));
  }

  // privacy
  getPrivacySettings(): Promise<CatalystPrivacySettings> {
    return this.http.request(CatalystEndpoint.getPrivacySettings());
  }

  updatePrivacySettings(
    data: CatalystPrivacySettingsRequest,
  ): Promise<CatalystPrivacySettings> {
    return this.http.request(CatalystEndpoint.updatePrivacySettings(data));
  }

  // announcements

  announcements(): Promise<{ announcements: CatalystAnnouncement[] }> {
    return this.http.request(CatalystEndpoint.announcements());
  }

  // profile tags

  updateProfileTags(
    data: UpdateProfileTagsRequest,
  ): Promise<{ tags: ProfileTag[] }> {
    return this.http.request(CatalystEndpoint.updateProfileTags(data));
  }

  profileTagSuggestions(
    q: string,
  ): Promise<{ tags: ProfileTagSuggestion[] }> {
    return this.http.request(CatalystEndpoint.profileTagSuggestions(q));
  }

  getUsersByProfileTag(
    name: string,
    cursor?: string,
  ): Promise<{
    items: ProfileTagUser[];
    cursor: string | null;
  }> {
    return this.http.request(
      CatalystEndpoint.getUsersByProfileTag(name, cursor),
    );
  }

  getProfileTagsByUser(id: string): Promise<{ tags: ProfileTag[] }> {
    return this.http.request(CatalystEndpoint.getProfileTagsByUser(id));
  }

  // random

  randomStatus(): Promise<{ status: CatalystStatus | null }> {
    return this.http.request(CatalystEndpoint.randomStatus());
  }

  randomStatusByHashtag(
    q: string,
  ): Promise<{ status: CatalystStatus | null }> {
    return this.http.request(CatalystEndpoint.randomStatusByHashtag(q));
  }

  // bulk reactions

  bulkStatusReactions(
    ids: string[],
  ): Promise<{ reactions: Record<string, CatalystReactions> }> {
    return this.http.request(CatalystEndpoint.bulkStatusReactions(ids));
  }

  // archive timeline

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
  }): Promise<{ statuses: CatalystStatus[] }> {
    return this.http.request(CatalystEndpoint.archiveTimeline(opts));
  }

  archiveMonths(): Promise<{
    months: { year: number; month: number; count: number }[];
  }> {
    return this.http.request(CatalystEndpoint.archiveMonths());
  }

  // contests

  currentContests(): Promise<{ contests: CatalystContest[] }> {
    return this.http.request(CatalystEndpoint.currentContests());
  }

  getContestsByUser(username: string): Promise<{ contests: CatalystContest[] }> {
    return this.http.request(CatalystEndpoint.getContestsByUser(username));
  }

  getContestPolls(slug: string): Promise<{
    polls: { status: CatalystStatus; count: number }[];
  }> {
    return this.http.request(CatalystEndpoint.getContestPolls(slug));
  }

  // album by me

  getAlbumsByMe(includeSmartAlbums = false): Promise<{ albums: CatalystAlbum[] }> {
    return this.http.request(CatalystEndpoint.getAlbumsByMe(includeSmartAlbums));
  }

  // smart album by user

  listSmartAlbumsByUser(username: string): Promise<{ albums: CatalystSmartAlbum[] }> {
    return this.http.request(CatalystEndpoint.listSmartAlbumsByUser(username));
  }
}
