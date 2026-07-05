// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

/// The author/creator of a world on a given platform.
public struct EpicleseAuthor: Decodable, Sendable, Equatable, Hashable {
  public let id: String
  public let platformIdentifier: String
  public let platform: EpiclesePlatform?
  public let name: String
}

public struct EpicleseAuthorWrapper: Decodable, Sendable {
  public let author: EpicleseAuthor
}

/// Paginated result of listing/searching authors.
public struct EpicleseAuthorsResult: Decodable, Sendable {
  public let items: [EpicleseAuthor]
  public let count: CatalystCountInfo
  public let page: CatalystPageInfo
}

/// Request body for `POST /epiclese/v1/authors`.
public struct EpicleseCreateAuthorRequest: Encodable, Sendable {
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
