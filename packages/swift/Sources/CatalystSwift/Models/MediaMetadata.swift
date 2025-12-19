// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct MediaMetadata: Decodable, Sendable, Equatable, Hashable {
  public let width: Int?
  public let height: Int?
  public let isSensitive: Bool
  public let isSpoiler: Bool
}
