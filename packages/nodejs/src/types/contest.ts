import { CatalystStatus } from "./status";
import { EgeriaUser } from "./users";

export interface CatalystCreateContestRequest {
  title: string;
  description: string;
  theme: string;
}

export interface CatalystEditContestRequest {
  title?: string;
  description?: string;
  theme?: string;
  terms?: string;
  headerUrl?: string;
  bannerUrl?: string;
  winnersOpenAt?: string;
  winnersMessageSendAt?: string;
  publishedAt?: string;
  application?: { since?: string; until?: string; allowSensitive: boolean };
  voting?: {
    since?: string;
    until?: string;
    maxVotes?: number;
    isEnableVoting?: boolean;
  };
  ranks?: Omit<CatalystContestRank, "id" | "winners">[];
}

export interface CatalystContestRank {
  id: string;
  name: string;
  description?: string;
  count: number;
  prize: string;
  winners: EgeriaUser[];
}

export interface CatalystContest {
  slug: string;
  draft: boolean;
  state: string;
  title: string;
  description: string;
  theme: string;
  terms: string;
  headerUrl: string;
  bannerUrl: string;
  winnersOpenAt: string;
  winnersMessageSendAt: string;
  publishedAt: string;
  application: { since: string; until: string; allowSensitive: boolean };
  voting: { since: string; until: string; maxVotes: number; isEnable: boolean };
  winners: { since: string; until: string };
  ranks: CatalystContestRank[];
}

export interface CatalystContestAward {
  id: string;
  name: string;
  winners: CatalystStatus &
    {
      message?: string | null;
      commentary?: string | null;
      attachment?: { name: string; id: string } | null;
    }[];
  order: number;
  count: number;
  remaining: number;
}

export interface CatalystSetContestAwardRequest {
  status: string;
  message?: string;
  commentary?: string;
}

export interface CatalystUnsetContestAwardRequest {
  status: string;
  message?: string;
  commentary?: string;
}

export interface CatalystContestCollaborator {
  user: Omit<EgeriaUser, "profile">;
  role: "admin" | "collaborator" | "contributor";
}

export interface CatalystContestAddCollaboratorRequest {
  userId: string;
  role: "collaborator" | "contributor";
}

export interface CatalystContestRemoveCollaboratorRequest {
  userId: string;
}

export interface CatalystContestPolls {
  status: CatalystStatus;
  count: number;
}

export interface CatalystUserVoteRights {
  remaining: number;
  statuses: string[];
}
