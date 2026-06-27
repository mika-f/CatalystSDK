// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct CatalystCustomReaction: Decodable, Sendable, Equatable, Hashable {
  public let id: String
  public let shortcode: String
  public let displayName: String
  public let imageUrl: String
  public let mimeType: String
  public let sortOrder: Int
  public let status: String
  public let createdAt: String
}

public struct CatalystCustomReactionList: Decodable, Sendable {
  public let plan: String
  public let limit: Int
  public let used: Int
  public let items: [CatalystCustomReaction]
}
