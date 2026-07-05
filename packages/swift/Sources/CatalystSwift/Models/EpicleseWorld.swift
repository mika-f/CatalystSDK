// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

/// A world/scene registered on a given platform.
public struct EpicleseWorld: Decodable, Sendable, Equatable, Hashable {
  public let id: String
  public let platformIdentifier: String
  public let platform: EpiclesePlatform?
  public let name: String
  public let author: EpicleseAuthor?
}

/// Wrapper for the `{"world": {...} | null}` response shape.
public struct EpicleseWorldWrapper: Decodable, Sendable {
  public let world: EpicleseWorld?
}

/// Wrapper for the `{"items": [...]}` response shape.
public struct EpicleseWorldsResult: Decodable, Sendable {
  public let items: [EpicleseWorld]
}

/// Request body for `POST /epiclese/v1/worlds`.
public struct EpicleseCreateWorldAuthorRequest: Encodable, Sendable {
  public let id: String?
  public let platformIdentifier: String
  public let platform: String
  public let name: String

  public init(id: String? = nil, platformIdentifier: String, platform: String, name: String) {
    self.id = id
    self.platformIdentifier = platformIdentifier
    self.platform = platform
    self.name = name
  }
}

/// Request body for `POST /epiclese/v1/worlds`.
public struct EpicleseCreateWorldRequest: Encodable, Sendable {
  public let id: String?
  public let platformIdentifier: String
  public let platform: String
  public let name: String
  public let author: EpicleseCreateWorldAuthorRequest?

  public init(
    id: String? = nil, platformIdentifier: String, platform: String, name: String,
    author: EpicleseCreateWorldAuthorRequest? = nil
  ) {
    self.id = id
    self.platformIdentifier = platformIdentifier
    self.platform = platform
    self.name = name
    self.author = author
  }
}
