// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct CatalystAlbum: Decodable, Equatable, Hashable, Sendable {
  public let id: String
  public let name: String
  public let description: String
  public let isPublic: Bool
  public let mode: CatalystAlbumDisplayMode
  public let user: EgeriaUser
  public let statuses: [CatalystStatus]
}

/// Wrapper for the `{"albums": [...]}` response shape, used by
/// `GET /catalyst/v1/status/{id}/albums`.
public struct CatalystAlbumsWrapper: Decodable, Sendable {
  public let albums: [CatalystAlbum]
}
