// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

import Foundation

public struct CatalystSmartAlbum: Decodable, Sendable, Equatable, Hashable {
  public let id: String
  public let name: String
  public let description: String
  public let isAllowNsfw: Bool
  public let isAllowOthers: Bool
  public let since: Date?
  public let until: Date?
  public let isPublic: Bool
  public let mode: CatalystAlbumDisplayMode
  public let user: EgeriaUser
  public let type: String?
  public let statuses: [CatalystStatus]
  public let hashtags: [String]
}
