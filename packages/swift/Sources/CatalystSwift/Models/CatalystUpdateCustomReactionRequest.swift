// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct CatalystUpdateCustomReactionRequest: Encodable, Sendable {
  public let displayName: String?
  public let sortOrder: Int?

  public init(displayName: String? = nil, sortOrder: Int? = nil) {
    self.displayName = displayName
    self.sortOrder = sortOrder
  }
}
