export interface CatalystRelationships {
  isMyself: boolean;
  isFollowing: boolean;
  isFollowed: boolean;
}

export interface CatalystRelationshipRequest {
  userId: string;
}
