// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct Media: Decodable, Sendable, Equatable, Hashable {
  public let id: String
  public let alt: String
  public let url: String
  public let metadata: MediaMetadata?
  public let privacyMetadata: Bool?
}
