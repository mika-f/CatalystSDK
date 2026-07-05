// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct CatalystUpdateProfileTagsRequest: Encodable, Sendable {
  public let tags: [String]

  public init(tags: [String]) {
    self.tags = tags
  }
}
