// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

import Foundation

/// A platform recognized by Epiclese (e.g. VRChat, Resonite).
public struct EpiclesePlatform: Decodable, Sendable, Equatable, Hashable {
  public let id: String
  public let name: String
  public let description: String
  public let url: String?
  public let startAt: Date?
}

public struct EpiclesePlatformWrapper: Decodable, Sendable {
  public let platform: EpiclesePlatform
}

public struct EpiclesePlatformsWrapper: Decodable, Sendable {
  public let platforms: [EpiclesePlatform]
}
