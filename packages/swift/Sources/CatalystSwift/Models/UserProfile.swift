// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct UserProfile: Codable, Equatable, Hashable, Sendable {
  public let iconUrl: String
  public let bannerUrl: String
  public let bio: String
  public let website: String
  public let additionalWebsites: [String]
}
