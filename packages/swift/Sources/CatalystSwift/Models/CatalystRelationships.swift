// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct CatalystRelationships: Decodable, Sendable, Equatable, Hashable {
  public let isMyself: Bool
  public let isFollowing: Bool
  public let isFollowed: Bool
  public let isBlocking: Bool
}

/// Following/follower counts for a user.
public struct CatalystRelationshipsCount: Decodable, Sendable, Equatable, Hashable {
  public let followings: Int?
  public let followers: Int?
}

/// Paginated list of a user's followers or followings.
public struct CatalystFollowingOrFollowersList: Decodable, Sendable {
  public let items: [EgeriaUser]
  public let count: CatalystCountInfo
  public let page: CatalystPageInfo
}
