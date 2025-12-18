// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct CatalystAlbum: Decodable, Sendable {
  public let id: String
  public let name: String
  public let description: String
  public let isPublic: Bool
  public let mode: CatalystAlbumDisplayMode
  public let user: EgeriaUser
  public let statuses: [CatalystStatus]
}
