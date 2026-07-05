// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

/// A profile tag.
public struct CatalystProfileTag: Decodable, Sendable, Equatable, Hashable {
  public let id: String
  public let name: String
  public let normalizedName: String
}

/// Wrapper for the `{"tags": [...]}` response shape.
public struct CatalystProfileTagsWrapper: Decodable, Sendable {
  public let tags: [CatalystProfileTag]
}

/// A profile tag suggestion, including usage count.
public struct CatalystProfileTagSuggestion: Decodable, Sendable, Equatable, Hashable {
  public let id: String
  public let name: String
  public let usageCount: Int
}

/// Wrapper for the `{"tags": [...]}` response shape (profile tag suggestions).
public struct CatalystProfileTagSuggestionsWrapper: Decodable, Sendable {
  public let tags: [CatalystProfileTagSuggestion]
}

/// A user matched by a profile tag search, including which tags matched.
public struct CatalystProfileTagUser: Decodable, Sendable, Equatable, Hashable {
  public let id: String
  public let screenName: String
  public let displayName: String
  public let profile: EgeriaUserProfile?
  public let profileEmoji: EgeriaUserProfileEmoji?
  public let matchedTags: [String]
}

/// Summary information for a profile tag (used within `CatalystProfileTagUsersResult`).
public struct CatalystProfileTagSummary: Decodable, Sendable, Equatable, Hashable {
  public let name: String
  public let usageCount: Int
}

/// Result of listing users by profile tag, including cursor-based pagination.
public struct CatalystProfileTagUsersResult: Decodable, Sendable {
  public let tag: CatalystProfileTagSummary
  public let users: [CatalystProfileTagUser]
  public let nextCursor: String?
}
