// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct MediaMetadata: Codable, Equatable, Hashable, Sendable {
  public let width: Int
  public let height: Int
  public let isSensitive: Bool
}
