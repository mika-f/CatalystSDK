// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct AvailableReaction: Codable, Equatable, Identifiable, Hashable, Sendable {
  public let id: String
  public let name: String
  public let symbol: String
  public let url: String
}

public struct Reaction: Codable, Equatable, Hashable, Sendable {
  public let name: String
  public let symbol: String
  public let url: String
  public let count: Int
  public let hasSelfReaction: Bool?
}

public struct ReactionWrapped: Codable, Sendable {
  public let reactions: [String: Reaction]
}

public struct ReactedValue: Codable, Sendable {
  public let value: Int
}
