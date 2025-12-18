// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct CatalystRelationships: Decodable, Sendable {
  public let isMyself: Bool
  public let isFollowing: Bool
  public let isFollowed: Bool
}
