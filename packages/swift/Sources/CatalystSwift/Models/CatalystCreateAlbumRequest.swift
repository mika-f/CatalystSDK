// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct CatalystCreateAlbumRequest: Encodable, Sendable {
  public let title: String
  public let description: String
  public let isPublic: Bool
  public let mode: CatalystAlbumDisplayMode
  
  init(title: String, description: String, isPublic: Bool, mode: CatalystAlbumDisplayMode) {
    self.title = title
    self.description = description
    self.isPublic = isPublic
    self.mode = mode
  }
}
