import type { EgeriaUser } from "./users.js";
import type { CountInfo, PageInfo } from "./common.js";

export interface CatalystRelationships {
  isMyself: boolean;
  isFollowing: boolean;
  isFollowed: boolean;
  isBlocking: boolean;
}

export interface CatalystRelationshipRequest {
  userId: string;
}

/** Following/follower counts for a user. */
export interface CatalystRelationshipsCount {
  followings: number | null;
  followers: number | null;
}

/** Paginated list of a user's followers or followings. */
export interface CatalystFollowingOrFollowersList {
  items: EgeriaUser[];
  count: CountInfo;
  page: PageInfo;
}
