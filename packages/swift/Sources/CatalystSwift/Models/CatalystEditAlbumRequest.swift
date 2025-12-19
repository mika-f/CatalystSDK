// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct CatalystEditAlbumRequest: Encodable, Sendable {
  public let title: String
  public let description: String
  public let isPublic: Bool
  public let mode: CatalystAlbumDisplayMode
  
  public init(title: String, description: String, isPublic: Bool, mode: CatalystAlbumDisplayMode) {
    self.title = title
    self.description = description
    self.isPublic = isPublic
    self.mode = mode
  }
}
