// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct CatalystCreateCustomReactionRequest: Encodable, Sendable {
  public let shortcode: String
  public let displayName: String

  public init(shortcode: String, displayName: String) {
    self.shortcode = shortcode
    self.displayName = displayName
  }
}
