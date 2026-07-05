// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

/// A single month bucket in the status archive.
public struct CatalystArchiveMonth: Decodable, Sendable, Equatable, Hashable {
  public let year: Int
  public let month: Int
  public let count: Int
}

public struct CatalystArchiveMonths: Decodable, Sendable {
  public let months: [CatalystArchiveMonth]
}
