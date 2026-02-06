// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct CatalystEditStatusRequest: Encodable, Sendable {
  public let description: String

  public init(description: String) {
    self.description = description
  }
}
