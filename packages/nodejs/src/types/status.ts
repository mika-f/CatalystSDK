import type { EgeriaUser } from "./users.js";
import type { Media } from "./media.js";
import type { CatalystMediaWithMetadata } from "./media.js";

export type CatalystStatusPrivacy = "public" | "quiet_public" | "followers" | "private";

export interface CatalystStatus {
  id: string;
  body: string;
  user?: EgeriaUser;
  medias: Media[];
  createdAt: string;
  updatedAt?: string;
}

export interface CatalystStatusWrapper {
  status: CatalystStatus;
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
