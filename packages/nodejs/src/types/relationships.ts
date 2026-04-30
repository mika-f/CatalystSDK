export interface CatalystRelationships {
  isMyself: boolean;
  isFollowing: boolean;
  isFollowed: boolean;
  isBlocking: boolean;
}

export interface CatalystRelationshipRequest {
  userId: string;
}
