// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki
import Foundation

public struct CatalystEditSmartAlbumRequest: Encodable, Sendable {
  public let title: String
  public let description: String
  public let hashtags: [String]
  public let since: Date?
  public let until: Date?
  public let isAllowNsfw: Bool?
  public let isAllowOthers: Bool?
  public let mode: CatalystAlbumDisplayMode?
}
