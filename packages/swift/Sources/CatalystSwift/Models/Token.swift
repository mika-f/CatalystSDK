// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct Token: Codable, Sendable {
  public let accessToken: String
  public let refreshToken: String
  public let tokenType: String
  public let scope: String?

  /// ISO8601 string, or nil when unset. Kept as a raw string (rather than `Date`) since the
  /// OAuth token-exchange decoder does not configure a date decoding strategy.
  public let expiresAt: String?
  public let expiresIn: Int?
}
