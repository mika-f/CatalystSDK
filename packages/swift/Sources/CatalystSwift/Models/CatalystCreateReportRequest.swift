// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

/// Request body for `POST /catalyst/v1/status/{id}/report`.
///
/// `reason` is one of "nsfw" | "tos_violation" | "harassment" | "spam" | "other".
public struct CatalystCreateReportRequest: Encodable, Sendable {
  public let reason: String
  public let description: String?

  public init(reason: String, description: String? = nil) {
    self.reason = reason
    self.description = description
  }
}
