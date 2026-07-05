// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

/// A single tagged reference (e.g. a face/area tagged in a photo) within a status metadata tag.
public struct EpicleseStatusMetadataReference: Decodable, Sendable, Equatable, Hashable {
  public let x: Double
  public let y: Double
  public let reference: String?
  public let type: String
  public let name: String
  public let description: String?
  public let externalUrl: String?
  public let author: EpicleseAuthor?
}

/// Metadata tagged onto a status, keyed by tag id.
///
/// `GET`/`POST /epiclese/v1/tag/by/status/{id}` return a dictionary keyed by tag id.
public struct EpicleseStatusMetadataTag: Decodable, Sendable {
  public let platform: String?
  public let world: EpicleseWorld?
  public let users: [EgeriaUser]
  public let reference: [EpicleseStatusMetadataReference]
  public let additionalData: [String: String]?
}

// MARK: - Request types for POST /epiclese/v1/tag/by/status/{id}

public struct EpicleseCreateStatusMetadataUserRequest: Encodable, Sendable {
  public let id: String

  public init(id: String) {
    self.id = id
  }
}

public struct EpicleseCreateStatusMetadataReferenceRequest: Encodable, Sendable {
  public let x: Int
  public let y: Int
  public let reference: String?
  public let type: String
  public let name: String
  public let description: String?
  public let externalUrl: String?
  public let author: EpicleseCreateWorldAuthorRequest?

  public init(
    x: Int, y: Int, reference: String? = nil, type: String, name: String,
    description: String? = nil, externalUrl: String? = nil,
    author: EpicleseCreateWorldAuthorRequest? = nil
  ) {
    self.x = x
    self.y = y
    self.reference = reference
    self.type = type
    self.name = name
    self.description = description
    self.externalUrl = externalUrl
    self.author = author
  }
}

public struct EpicleseCreateStatusMetadataTagRequest: Encodable, Sendable {
  public let id: String?
  public let platform: String?
  public let world: EpicleseCreateWorldRequest?
  public let users: [EpicleseCreateStatusMetadataUserRequest]
  public let reference: [EpicleseCreateStatusMetadataReferenceRequest]
  public let privacyMetadata: Bool?

  public init(
    id: String? = nil,
    platform: String? = nil,
    world: EpicleseCreateWorldRequest? = nil,
    users: [EpicleseCreateStatusMetadataUserRequest] = [],
    reference: [EpicleseCreateStatusMetadataReferenceRequest],
    privacyMetadata: Bool? = nil
  ) {
    self.id = id
    self.platform = platform
    self.world = world
    self.users = users
    self.reference = reference
    self.privacyMetadata = privacyMetadata
  }
}
