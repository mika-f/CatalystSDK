// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct CatalystRelationshipRequest: Encodable, Sendable {
  public let userId: String

  public init(userId: String) {
    self.userId = userId
  }
}
