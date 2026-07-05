// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

/// The profile emoji shown alongside a user's name.
///
/// This flattens the spec's `anyOf` union, discriminated by `type`:
/// - `"standard"` populates `value` and `imageUrl`.
/// - `"custom"` populates `id`, `shortcode`, `displayName`, `imageUrl`, `width` and `height`.
public struct EgeriaUserProfileEmoji: Decodable, Sendable, Equatable, Hashable {
  public let type: String
  public let value: String?
  public let id: String?
  public let shortcode: String?
  public let displayName: String?
  public let imageUrl: String?
  public let width: Double?
  public let height: Double?
}

public struct EgeriaUser: Decodable, Sendable, Equatable, Hashable {
  public let id: String
  public let screenName: String
  public let displayName: String
  public let profile: EgeriaUserProfile?
  public let profileEmoji: EgeriaUserProfileEmoji?
}

public struct EgeriaUserWrapper: Decodable, Sendable {
  public let user: EgeriaUser
}
