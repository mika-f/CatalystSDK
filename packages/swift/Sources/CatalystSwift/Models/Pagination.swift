// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

/// Total/offset counters used by several list endpoints.
public struct CatalystCountInfo: Decodable, Sendable, Equatable, Hashable {
  public let total: Int
  public let offset: Int
}

/// Page cursor metadata used by several list endpoints.
public struct CatalystPageInfo: Decodable, Sendable, Equatable, Hashable {
  public let min: Int
  public let max: Int
  public let current: Int
  public let next: Int?
  public let prev: Int?
}
