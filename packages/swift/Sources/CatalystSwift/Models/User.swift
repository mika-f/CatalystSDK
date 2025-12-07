// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct User: Codable, Equatable, Hashable, Identifiable, Sendable {
  public let id: String
  public let screenName: String
  public let displayName: String
  public let profile: UserProfile
}

public struct UserWrapped: Codable, Sendable {
  public let user: User
}
