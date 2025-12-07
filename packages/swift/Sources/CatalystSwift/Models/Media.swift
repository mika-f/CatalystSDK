// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct Media: Codable, Equatable, Hashable, Identifiable, Sendable {
  public let id: String
  public let alt: String
  public let url: String
  public let metadata: MediaMetadata?
}
