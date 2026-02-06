// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct CatalystInsertToAlbumRequest: Encodable, Sendable {
  public let insert: String

  public init(insert: String) {
    self.insert = insert
  }
}
