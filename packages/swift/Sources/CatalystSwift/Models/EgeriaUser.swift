// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct EgeriaUser: Decodable, Sendable, Equatable, Hashable {
  public let id: String
  public let screenName: String
  public let displayName: String
  public let profile: EgeriaUserProfile?
}

public struct EgeriaUserWrapper: Decodable, Sendable {
  public let user: EgeriaUser
}
