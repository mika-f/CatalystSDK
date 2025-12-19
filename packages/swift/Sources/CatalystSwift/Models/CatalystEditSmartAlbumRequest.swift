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

  public init(
    title: String,
    description: String,
    hashtags: [String],
    since: Date?,
    until: Date?,
    isAllowNsfw: Bool?,
    isAllowOthers: Bool?,
    mode: CatalystAlbumDisplayMode?
  ) {
    self.title = title
    self.description = description
    self.hashtags = hashtags
    self.since = since
    self.until = until
    self.isAllowNsfw = isAllowNsfw
    self.isAllowOthers = isAllowOthers
    self.mode = mode
  }
}
