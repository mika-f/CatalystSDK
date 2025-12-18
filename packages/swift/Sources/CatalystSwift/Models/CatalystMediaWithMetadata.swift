// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct CatalystMediaWithMetadata: Encodable, Sendable {
  public let url: String
  public let alt: String
  public let width: Int
  public let height: Int
  public let bytes: Int
}
