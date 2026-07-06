import { EgeriaUser } from "./users.js";

export interface CatalystContestRank {
  id: string;
  name: string;
  description?: string;
  count: number;
  prize: string;
  winners: EgeriaUser[];
}

export type CatalystContestState =
  | "draft"
  | "published"
  | "opening"
  | "closing"
  | "voting"
  | "electing"
  | "closed";

// NOTE: the spec only exposes read + vote operations for contests. Contest management
// (create/edit/awards/collaborators/copy/dashboard/publish/polls) is no longer part of the API.
export interface CatalystContest {
  slug: string;
  draft: boolean;
  state: CatalystContestState;
  title: string;
  description: string;
  theme: string;
  terms: string;
  headerUrl: string;
  bannerUrl: string;
  organizer: EgeriaUser;
  winnersOpenAt: string;
  winnersMessageSendAt: string;
  publishedAt: string;
  since: string;
  until: string;
  allowSensitive: boolean;
  maxMediaPerEntry: number | null;
  voting: { since: string; until: string; maxVotes: number; isEnable: boolean };
  ranks: CatalystContestRank[];
}

export interface CatalystContestWrapper {
  contest: CatalystContest;
}

export interface CatalystContestsWrapper {
  contests: CatalystContest[];
}

/** The current user's remaining vote allowance for a contest. */
export interface CatalystUserVoteRights {
  remaining: number;
  statuses: string[];
}
