// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

import Foundation

/// A platform-wide announcement.
public struct CatalystAnnouncement: Decodable, Sendable, Equatable, Hashable {
  public let id: String
  public let title: String
  public let body: String
  public let category: String
  public let since: Date
  public let until: Date
  public let url: String?
}

public struct CatalystAnnouncementsWrapper: Decodable, Sendable {
  public let announcements: [CatalystAnnouncement]
}
