import { CatalystEndpoint } from "../endpoints/catalystEndpoint.js";
import type { HttpClient } from "./httpClient.js";
import type { Identity } from "../types/identity.js";
import type {
  CatalystAlbum,
  CatalystAlbumsWrapper,
  CatalystAlbumBook,
  CatalystAlbumOrSmartAlbum,
  CatalystAlbumOrSmartAlbums,
  CatalystSmartAlbum,
  CatalystSmartAlbums,
  CatalystCreateAlbumRequest,
  CatalystEditAlbumRequest,
  CatalystCreateSmartAlbumRequest,
  CatalystEditSmartAlbumRequest,
  CatalystCreateAlbumBookRequest,
} from "../types/albums.js";
import type {
  CatalystStatus,
  CatalystStatusV1_1,
  CatalystStatusV1Wrapper,
  CatalystStatusV1_1Wrapper,
  CatalystRandomStatusWrapper,
  CatalystStatuses,
  CatalystStatusesV1_1,
  CatalystCreateStatusRequest,
} from "../types/status.js";
import type {
  CatalystReaction,
  CatalystReactions,
  CatalystCustomReaction,
  CatalystCustomReactionList,
  CatalystUserCustomReaction,
  UpdateCustomReactionRequest,
} from "../types/reactions.js";
import type {
  CatalystRelationships,
  CatalystRelationshipsCount,
  CatalystFollowingOrFollowersList,
} from "../types/relationships.js";
import {
  CatalystCreateFleetRequest,
  CatalystFleet,
  CatalystFleetRing,
  CatalystFleetViewer,
} from "../types/fleet.js";
import { CatalystContest, CatalystContestWrapper, CatalystContestsWrapper, CatalystUserVoteRights } from "../types/contest.js";
import { ReportRequest } from "../types/report.js";
import {
  CatalystPrivacySettings,
  CatalystPrivacySettingsRequest,
} from "../types/privacy.js";
import { CatalystAnnouncement, CatalystAnnouncementsWrapper } from "../types/announcements.js";
import {
  ProfileTag,
  ProfileTagsWrapper,
  ProfileTagSuggestion,
  ProfileTagSuggestionsWrapper,
  ProfileTagUsersResult,
  UpdateProfileTagsRequest,
} from "../types/profileTags.js";
import { CatalystArchiveMonth, CatalystArchiveMonths } from "../types/archive.js";
import { CatalystRichTrendingItem } from "../types/trend.js";
import {
  CatalystResult,
  CatalystReactionValue,
  CatalystMessage,
} from "../types/common.js";

export class CatalystClient {
  constructor(private readonly http: HttpClient) {}

  // Albums

  createAlbum(data: CatalystCreateAlbumRequest): Promise<Identity> {
    return this.http.request(CatalystEndpoint.createAlbum(data));
  }

  getAlbum(
    id: string,
    opts: { limit?: number; since?: string; until?: string } = {},
  ): Promise<CatalystAlbum> {
    return this.http.request(CatalystEndpoint.getAlbum(id, opts));
  }

  insertToAlbum(id: string, statusId: string): Promise<CatalystResult> {
    return this.http.request(CatalystEndpoint.insertToAlbum(id, statusId));
  }

  removeFromAlbum(id: string, statusId: string): Promise<CatalystResult> {
    return this.http.request(CatalystEndpoint.removeFromAlbum(id, statusId));
  }

  editAlbum(id: string, data: CatalystEditAlbumRequest): Promise<CatalystResult> {
    return this.http.request(CatalystEndpoint.editAlbum(id, data));
  }

  deleteAlbum(id: string): Promise<CatalystResult> {
    return this.http.request(CatalystEndpoint.deleteAlbum(id));
  }

  getAlbumBooks(id: string): Promise<CatalystAlbumBook[]> {
    return this.http.request(CatalystEndpoint.getAlbumBooks(id));
  }

  createAlbumBook(
    id: string,
    data: CatalystCreateAlbumBookRequest,
  ): Promise<CatalystAlbumBook> {
    return this.http.request(CatalystEndpoint.createAlbumBook(id, data));
  }

  getAlbumBook(id: string, bookId: string): Promise<CatalystAlbumBook> {
    return this.http.request(CatalystEndpoint.getAlbumBook(id, bookId));
  }

  regenerateAlbumBook(id: string, bookId: string): Promise<CatalystAlbumBook> {
    return this.http.request(CatalystEndpoint.regenerateAlbumBook(id, bookId));
  }

  async getAlbumsByMe(includeSmartAlbums = false): Promise<CatalystAlbumOrSmartAlbum[]> {
    const response = await this.http.request<CatalystAlbumOrSmartAlbums>(
      CatalystEndpoint.getAlbumsByMe(includeSmartAlbums),
    );
    return response.albums;
  }

  async listAlbums(
    username: string,
    includeSmartAlbum = true,
  ): Promise<CatalystAlbumOrSmartAlbum[]> {
    const response = await this.http.request<CatalystAlbumOrSmartAlbums>(
      CatalystEndpoint.listAlbums(username, includeSmartAlbum),
    );
    return response.albums;
  }

  async searchAlbums(
    q?: string,
    includeSmartAlbum = true,
    until?: string,
  ): Promise<CatalystAlbumOrSmartAlbum[]> {
    const response = await this.http.request<CatalystAlbumOrSmartAlbums>(
      CatalystEndpoint.searchAlbums(q, includeSmartAlbum, until),
    );
    return response.albums;
  }

  // Announcements

  async announcements(): Promise<CatalystAnnouncement[]> {
    const response = await this.http.request<CatalystAnnouncementsWrapper>(
      CatalystEndpoint.announcements(),
    );
    return response.announcements;
  }

  // Blocks

  block(userId: string): Promise<CatalystResult> {
    return this.http.request(CatalystEndpoint.block(userId));
  }

  unblock(userId: string): Promise<CatalystResult> {
    return this.http.request(CatalystEndpoint.unblock(userId));
  }

  // Contest
  // NOTE: the spec only exposes read + vote operations for contests; contest management
  // (create/edit/awards/collaborators/copy/dashboard/publish/polls) is no longer part of the API.

  async getContestsByMe(): Promise<CatalystContest[]> {
    const response = await this.http.request<CatalystContestsWrapper>(
      CatalystEndpoint.getContestsByMe(),
    );
    return response.contests;
  }

  async getContestBySlug(slug: string): Promise<CatalystContest> {
    const response = await this.http.request<CatalystContestWrapper>(
      CatalystEndpoint.getContestBySlug(slug),
    );
    return response.contest;
  }

  async contestTimeline(slug: string): Promise<CatalystStatus[]> {
    const response = await this.http.request<CatalystStatuses>(
      CatalystEndpoint.contestTimeline(slug),
    );
    return response.statuses;
  }

  getContestVotes(slug: string): Promise<CatalystUserVoteRights> {
    return this.http.request(CatalystEndpoint.getContestVotes(slug));
  }

  addContestVote(slug: string, status: string): Promise<CatalystResult> {
    return this.http.request(CatalystEndpoint.addContestVote(slug, status));
  }

  removeContestVote(slug: string, status: string): Promise<CatalystResult> {
    return this.http.request(CatalystEndpoint.removeContestVote(slug, status));
  }

  async getContestsByUser(userId: string): Promise<CatalystContest[]> {
    const response = await this.http.request<CatalystContestsWrapper>(
      CatalystEndpoint.getContestsByUser(userId),
    );
    return response.contests;
  }

  async currentContests(): Promise<CatalystContest[]> {
    const response = await this.http.request<CatalystContestsWrapper>(
      CatalystEndpoint.currentContests(),
    );
    return response.contests;
  }

  async searchContests(q?: string, state?: string, id?: string): Promise<CatalystContest[]> {
    const response = await this.http.request<CatalystContestsWrapper>(
      CatalystEndpoint.searchContests(q, state, id),
    );
    return response.contests;
  }

  // Custom reactions

  customReactions(): Promise<CatalystCustomReaction[]> {
    return this.http.request(CatalystEndpoint.customReactions());
  }

  getCustomUserReactions(): Promise<CatalystCustomReactionList> {
    return this.http.request(CatalystEndpoint.getCustomUserReactions());
  }

  /**
   * Creates a custom reaction. `data` must include the `image`, `shortcode`, `displayName` and
   * `visibility` ("private" | "followers" | "public") fields as multipart form fields.
   */
  createCustomReaction(data: FormData): Promise<CatalystUserCustomReaction> {
    return this.http.request(CatalystEndpoint.createCustomReaction(data));
  }

  updateCustomReaction(
    id: string,
    data: UpdateCustomReactionRequest,
  ): Promise<CatalystUserCustomReaction> {
    return this.http.request(CatalystEndpoint.updateCustomReaction(id, data));
  }

  deleteCustomReaction(id: string): Promise<void> {
    return this.http.requestVoid(CatalystEndpoint.deleteCustomReaction(id));
  }

  // Fleet

  createFleet(data: CatalystCreateFleetRequest): Promise<Identity> {
    return this.http.request(CatalystEndpoint.createFleet(data));
  }

  fleetByUsername(username: string): Promise<CatalystFleet[]> {
    return this.http.request(CatalystEndpoint.fleetByUsername(username));
  }

  fleets(): Promise<CatalystFleetRing[]> {
    return this.http.request(CatalystEndpoint.fleets());
  }

  fleetById(id: string): Promise<CatalystFleet> {
    return this.http.request(CatalystEndpoint.fleetById(id));
  }

  deleteFleet(id: string): Promise<CatalystResult> {
    return this.http.request(CatalystEndpoint.deleteFleet(id));
  }

  reactFleet(id: string, symbol: string): Promise<CatalystReactionValue> {
    return this.http.request(CatalystEndpoint.reactFleet(id, symbol));
  }

  unreactFleet(id: string, symbol: string): Promise<CatalystReactionValue> {
    return this.http.request(CatalystEndpoint.unreactFleet(id, symbol));
  }

  viewFleet(id: string): Promise<CatalystResult> {
    return this.http.request(CatalystEndpoint.viewFleet(id));
  }

  fleetViewers(id: string): Promise<CatalystFleetViewer[]> {
    return this.http.request(CatalystEndpoint.fleetViewers(id));
  }

  // Privacy

  getPrivacySettings(): Promise<CatalystPrivacySettings> {
    return this.http.request(CatalystEndpoint.getPrivacySettings());
  }

  updatePrivacySettings(
    data: CatalystPrivacySettingsRequest,
  ): Promise<CatalystPrivacySettings> {
    return this.http.request(CatalystEndpoint.updatePrivacySettings(data));
  }

  // Profile tags

  async updateProfileTags(data: UpdateProfileTagsRequest): Promise<ProfileTag[]> {
    const response = await this.http.request<ProfileTagsWrapper>(
      CatalystEndpoint.updateProfileTags(data),
    );
    return response.tags;
  }

  async profileTagSuggestions(q: string): Promise<ProfileTagSuggestion[]> {
    const response = await this.http.request<ProfileTagSuggestionsWrapper>(
      CatalystEndpoint.profileTagSuggestions(q),
    );
    return response.tags;
  }

  getUsersByProfileTag(name: string, cursor?: string): Promise<ProfileTagUsersResult> {
    return this.http.request(CatalystEndpoint.getUsersByProfileTag(name, cursor));
  }

  async getProfileTagsByUser(id: string): Promise<ProfileTag[]> {
    const response = await this.http.request<ProfileTagsWrapper>(
      CatalystEndpoint.getProfileTagsByUser(id),
    );
    return response.tags;
  }

  // Random

  async randomStatus(): Promise<CatalystStatus | null> {
    const response = await this.http.request<CatalystRandomStatusWrapper>(
      CatalystEndpoint.randomStatus(),
    );
    return response.status;
  }

  randomStatusV1_1(): Promise<CatalystStatusV1_1> {
    return this.http.request(CatalystEndpoint.randomStatusV1_1());
  }

  onThisDay(): Promise<CatalystStatusV1_1> {
    return this.http.request(CatalystEndpoint.onThisDay());
  }

  // Status

  createStatus(data: CatalystCreateStatusRequest): Promise<Identity> {
    return this.http.request(CatalystEndpoint.createStatus(data));
  }

  async getStatus(id: string): Promise<CatalystStatus> {
    const response = await this.http.request<CatalystStatusV1Wrapper>(
      CatalystEndpoint.getStatus(id),
    );
    return response.status;
  }

  async getStatusV1_1(id: string): Promise<CatalystStatusV1_1> {
    const response = await this.http.request<CatalystStatusV1_1Wrapper>(
      CatalystEndpoint.getStatusV1_1(id),
    );
    return response.status;
  }

  editStatus(id: string, description: string): Promise<Identity> {
    return this.http.request(
      CatalystEndpoint.editStatus(id, { description }),
    );
  }

  deleteStatus(id: string): Promise<CatalystMessage> {
    return this.http.request(CatalystEndpoint.deleteStatus(id));
  }

  async albumsInStatus(id: string): Promise<CatalystAlbum[]> {
    const response = await this.http.request<CatalystAlbumsWrapper>(
      CatalystEndpoint.albumsInStatus(id),
    );
    return response.albums;
  }

  isFavorited(id: string): Promise<boolean> {
    return this.http.request(CatalystEndpoint.isFavorited(id));
  }

  favorite(id: string): Promise<CatalystResult> {
    return this.http.request(CatalystEndpoint.favorite(id));
  }

  unfavorite(id: string): Promise<CatalystResult> {
    return this.http.request(CatalystEndpoint.unfavorite(id));
  }

  async reactions(id: string): Promise<Record<string, CatalystReaction>> {
    const response = await this.http.request<CatalystReactions>(
      CatalystEndpoint.reactions(id),
    );
    return response.reactions;
  }

  reactWithCustomReaction(id: string, customReactionId: string): Promise<void> {
    return this.http.requestVoid(
      CatalystEndpoint.reactWithCustomReaction(id, customReactionId),
    );
  }

  unreactWithCustomReaction(id: string, customReactionId: string): Promise<void> {
    return this.http.requestVoid(
      CatalystEndpoint.unreactWithCustomReaction(id, customReactionId),
    );
  }

  react(id: string, symbol: string): Promise<CatalystReactionValue> {
    return this.http.request(CatalystEndpoint.react(id, symbol));
  }

  unreact(id: string, symbol: string): Promise<CatalystReactionValue> {
    return this.http.request(CatalystEndpoint.unreact(id, symbol));
  }

  reportStatus(id: string, data: ReportRequest): Promise<Identity> {
    return this.http.request(CatalystEndpoint.reportStatus(id, data));
  }

  // Bulk status reactions

  async bulkStatusReactions(
    ids: string[],
  ): Promise<Record<string, Record<string, CatalystReaction>>> {
    const response = await this.http.request<{
      reactions: Record<string, Record<string, CatalystReaction>>;
    }>(CatalystEndpoint.bulkStatusReactions(ids));
    return response.reactions;
  }

  // Relationships

  follow(userId: string): Promise<CatalystResult> {
    return this.http.request(CatalystEndpoint.follow(userId));
  }

  remove(userId: string): Promise<CatalystResult> {
    return this.http.request(CatalystEndpoint.remove(userId));
  }

  relationshipCounts(username: string): Promise<CatalystRelationshipsCount> {
    return this.http.request(CatalystEndpoint.relationshipCounts(username));
  }

  followers(
    username: string,
    opts?: { page?: number },
  ): Promise<CatalystFollowingOrFollowersList> {
    return this.http.request(CatalystEndpoint.followers(username, opts));
  }

  followings(
    username: string,
    opts?: { page?: number },
  ): Promise<CatalystFollowingOrFollowersList> {
    return this.http.request(CatalystEndpoint.followings(username, opts));
  }

  relationships(id: string): Promise<CatalystRelationships> {
    return this.http.request(CatalystEndpoint.relationships(id));
  }

  // Smart albums

  createSmartAlbum(data: CatalystCreateSmartAlbumRequest): Promise<Identity> {
    return this.http.request(CatalystEndpoint.createSmartAlbum(data));
  }

  getSmartAlbum(
    id: string,
    opts: { limit?: number; since?: string; until?: string } = {},
  ): Promise<CatalystSmartAlbum> {
    return this.http.request(CatalystEndpoint.getSmartAlbum(id, opts));
  }

  editSmartAlbum(
    id: string,
    data: CatalystEditSmartAlbumRequest,
  ): Promise<CatalystSmartAlbum> {
    return this.http.request(CatalystEndpoint.editSmartAlbum(id, data));
  }

  deleteSmartAlbum(id: string): Promise<CatalystResult> {
    return this.http.request(CatalystEndpoint.deleteSmartAlbum(id));
  }

  getSmartAlbumBooks(id: string): Promise<CatalystAlbumBook[]> {
    return this.http.request(CatalystEndpoint.getSmartAlbumBooks(id));
  }

  createSmartAlbumBook(
    id: string,
    data: CatalystCreateAlbumBookRequest,
  ): Promise<CatalystAlbumBook> {
    return this.http.request(CatalystEndpoint.createSmartAlbumBook(id, data));
  }

  getSmartAlbumBook(id: string, bookId: string): Promise<CatalystAlbumBook> {
    return this.http.request(CatalystEndpoint.getSmartAlbumBook(id, bookId));
  }

  regenerateSmartAlbumBook(id: string, bookId: string): Promise<CatalystAlbumBook> {
    return this.http.request(CatalystEndpoint.regenerateSmartAlbumBook(id, bookId));
  }

  async listSmartAlbumsByUser(userId: string): Promise<CatalystSmartAlbum[]> {
    const response = await this.http.request<CatalystSmartAlbums>(
      CatalystEndpoint.listSmartAlbumsByUser(userId),
    );
    return response.albums;
  }

  async searchSmartAlbums(q?: string): Promise<CatalystSmartAlbum[]> {
    const response = await this.http.request<CatalystSmartAlbums>(
      CatalystEndpoint.searchSmartAlbums(q),
    );
    return response.albums;
  }

  // Timelines

  async archiveTimeline(opts: {
    year: number;
    month: number;
    day?: number;
    since?: string;
    until?: string;
    userId?: string;
    limit?: number;
    excludeSensitive?: boolean;
  }): Promise<CatalystStatus[]> {
    const response = await this.http.request<CatalystStatuses>(
      CatalystEndpoint.archiveTimeline(opts),
    );
    return response.statuses;
  }

  async archiveMonths(): Promise<CatalystArchiveMonth[]> {
    const response = await this.http.request<CatalystArchiveMonths>(
      CatalystEndpoint.archiveMonths(),
    );
    return response.months;
  }

  async timelineByContestSlug(
    slug: string,
    opts: { since?: string; until?: string } = {},
  ): Promise<CatalystStatus[]> {
    const response = await this.http.request<CatalystStatuses>(
      CatalystEndpoint.timelineByContestSlug(slug, opts),
    );
    return response.statuses;
  }

  async favoriteTimeline(
    opts: { since?: string; until?: string } = {},
  ): Promise<CatalystStatusV1_1[]> {
    const response = await this.http.request<CatalystStatusesV1_1>(
      CatalystEndpoint.favoriteTimeline(opts),
    );
    return response.statuses;
  }

  async firehoseTimelineV1(
    opts: { since?: string; until?: string } = {},
  ): Promise<CatalystStatus[]> {
    const response = await this.http.request<CatalystStatuses>(
      CatalystEndpoint.firehoseTimelineV1(opts),
    );
    return response.statuses;
  }

  async galleryTimeline(
    opts: { since?: string; until?: string } = {},
  ): Promise<CatalystStatus[]> {
    const response = await this.http.request<CatalystStatuses>(
      CatalystEndpoint.galleryTimeline(opts),
    );
    return response.statuses;
  }

  async homeTimelineV1(): Promise<CatalystStatus[]> {
    const response = await this.http.request<CatalystStatuses>(
      CatalystEndpoint.homeTimelineV1(),
    );
    return response.statuses;
  }

  async searchTimeline(
    opts: { q?: string; exact?: boolean; since?: string; until?: string } = {},
  ): Promise<CatalystStatus[]> {
    const response = await this.http.request<CatalystStatuses>(
      CatalystEndpoint.searchTimeline(opts),
    );
    return response.statuses;
  }

  async userTimeline(
    username: string,
    opts: {
      since?: string;
      until?: string;
      limit?: number;
      excludeSensitive?: boolean;
    } = {},
  ): Promise<CatalystStatus[]> {
    const response = await this.http.request<CatalystStatuses>(
      CatalystEndpoint.userTimeline(username, opts),
    );
    return response.statuses;
  }

  async userGalleryTimeline(
    username: string,
    opts: { since?: string; until?: string } = {},
  ): Promise<CatalystStatus[]> {
    const response = await this.http.request<CatalystStatuses>(
      CatalystEndpoint.userGalleryTimeline(username, opts),
    );
    return response.statuses;
  }

  firehoseTimeline(
    opts: { since?: string; until?: string; trimVisitor?: boolean } = {},
  ): Promise<CatalystStatusV1_1[]> {
    return this.http.request(CatalystEndpoint.firehoseTimeline(opts));
  }

  homeTimeline(
    opts: { since?: string; until?: string; trimVisitor?: boolean } = {},
  ): Promise<CatalystStatusV1_1[]> {
    return this.http.request(CatalystEndpoint.homeTimeline(opts));
  }

  // Trend

  trend(): Promise<string[] | null> {
    return this.http.request(CatalystEndpoint.trend());
  }

  richTrend(): Promise<CatalystRichTrendingItem[] | null> {
    return this.http.request(CatalystEndpoint.richTrend());
  }
}
