// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct MediaDeleteRequest: Encodable, Sendable {
  public let url: String
  
  public init(url: String) {
    self.url = url
  }
}
