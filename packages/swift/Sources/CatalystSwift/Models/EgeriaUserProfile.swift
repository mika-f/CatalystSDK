// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct EgeriaUserProfile: Codable, Sendable, Equatable, Hashable {
  public let iconUrl: String
  public let bannerUrl: String
  public let bio: String
  public let website: String
  public let additionalWebsies: [String]
  
  public init(iconUrl: String, bannerUrl: String, bio: String, website: String, additionalWebsies: [String]) {
    self.iconUrl = iconUrl
    self.bannerUrl = bannerUrl
    self.bio = bio
    self.website = website
    self.additionalWebsies = additionalWebsies
  }
}
