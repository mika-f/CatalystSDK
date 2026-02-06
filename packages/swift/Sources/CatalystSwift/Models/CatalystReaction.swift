// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct CatalystReaction: Decodable, Sendable, Equatable, Hashable {
  public let name: String
  public let symbol: String
  public let url: String
  public let count: Int
  public let hasSelfReaction: Bool?
}
