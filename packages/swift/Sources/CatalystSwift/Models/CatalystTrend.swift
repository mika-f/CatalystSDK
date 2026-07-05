// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

/// A single entry in the "rich" trending list (`GET /catalyst/v1/trend?format=rich`).
///
/// `movement` is one of "up" | "down" | "same" | "new".
public struct CatalystRichTrendingItem: Decodable, Sendable, Equatable, Hashable {
  public let tag: String
  public let rank: Int
  public let previousRank: Int?
  public let movement: String
}
