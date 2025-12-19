// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct EgeriaUpdateProfileRequest: Encodable, Sendable {
  public let screenName: String?
  public let displayName: String?
  public let profile: EgeriaUserProfile?
  
  public init(screenName: String?, displayName: String?, profile: EgeriaUserProfile?) {
    self.screenName = screenName
    self.displayName = displayName
    self.profile = profile
  }
}
