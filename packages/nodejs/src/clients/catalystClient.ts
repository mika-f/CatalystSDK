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
  CatalystStatusWrapper,
  CatalystStatuses,
  CatalystCreateStatusRequest,
  CatalystEditStatusRequest,
} from "../types/status.js";
import type {
  CatalystReactions,
  CatalystCustomReaction,
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
  CatalystContestRemoveCollaboratorRequest,
  CatalystCreateContestRequest,
  CatalystEditContestRequest,
  CatalystSetContestAwardRequest,
  CatalystUnsetContestAwardRequest,
  CatalystUserVoteRights,
} from "../types/contest.js";

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

  // Relationships

  relationships(id: string): Promise<CatalystRelationships> {
    return this.http.request(CatalystEndpoint.relationships(id));
  }

  follow(data: CatalystRelationshipRequest): Promise<void> {
    return this.http.requestVoid(CatalystEndpoint.follow(data));
  }

  remove(data: CatalystRelationshipRequest): Promise<void> {
    return this.http.requestVoid(CatalystEndpoint.remove(data));
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
  ): Promise<CatalystStatus[]> {
    return this.http.request(CatalystEndpoint.firehoseTimeline(opts));
  }

  galleryTimeline(
    opts: { since?: string; until?: string } = {},
  ): Promise<CatalystStatuses> {
    return this.http.request(CatalystEndpoint.galleryTimeline(opts));
  }

  homeTimeline(
    opts: { since?: string; until?: string } = {},
  ): Promise<CatalystStatus[]> {
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

  getContestCollaborators(slug: string): Promise<{ collaborators: string[] }> {
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
}
