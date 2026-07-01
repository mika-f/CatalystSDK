import type { EgeriaUser } from "./users.js";
import type { Media } from "./media.js";
import type { CatalystMediaWithMetadata } from "./media.js";
import type { CatalystReaction } from "./reactions.js";
import type { CatalystContest } from "./contest.js";

export type CatalystStatusPrivacy = "public" | "quiet_public" | "followers" | "private";

export type CatalystStatusContest = Pick<
  CatalystContest,
  "slug" | "title" | "headerUrl" | "bannerUrl"
>;

export interface CatalystStatus {
  id: string;
  body: string;
  user: EgeriaUser | null;
  medias: Media[];
  contest: CatalystStatusContest | null;
  createdAt: string;
  /** @deprecated 常に空配列。リアクションは reactions()/bulkStatusReactions() を利用すること */
  reactions: unknown[];
}

export interface CatalystStatusVisitor {
  favorite: boolean;
  reactions?: string[];
}

export interface CatalystStatusV1_1 {
  id: string;
  body: string;
  user: EgeriaUser | null;
  medias: Media[];
  contest: Pick<CatalystStatusContest, "slug" | "title" | "headerUrl"> | null;
  reactions: Record<string, Omit<CatalystReaction, "hasSelfReaction">>;
  createdAt: string;
  updatedAt: string;
  visitor?: CatalystStatusVisitor;
  privacy: CatalystStatusPrivacy;
}

export interface CatalystStatusWrapper {
  status: CatalystStatusV1_1;
}

export interface CatalystStatuses {
  statuses: CatalystStatus[];
}

export interface CatalystCreateStatusRequest {
  description: string;
  isNsfw: boolean;
  isSpoiler: boolean;
  isSubmitToContest: boolean;
  isHidingLikeAndViewCount: boolean;
  isPrivateMetadata?: boolean;
  isAllowComments: boolean;
  privacy?: CatalystStatusPrivacy;
  contestId?: string;
  media: CatalystMediaWithMetadata[];
}

export interface CatalystEditStatusRequest {
  description: string;
}
