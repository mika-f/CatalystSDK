// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

import Foundation

public struct CatalystStatusContest: Decodable, Sendable, Equatable, Hashable {
  public let slug: String
  public let title: String
  public let headerUrl: String
  public let bannerUrl: String?
}

public struct CatalystStatus: Decodable, Sendable, Equatable, Hashable {
  public let id: String
  public let body: String
  public let user: EgeriaUser?
  public let medias: [Media]
  public let contest: CatalystStatusContest?
  public let createdAt: Date

  /// - Deprecated: The real API always serializes this as an empty array; contents are not modeled.
  public let reactions: [String]?
}

/// Wrapper for the `{"status": {...}}` response shape, used by `GET /catalyst/v1/status/{id}`.
public struct CatalystStatusV1Wrapper: Decodable, Sendable {
  public let status: CatalystStatus
}

/// Wrapper for the `{"status": {...} | null}` response shape, used by `GET /catalyst/v1/random`.
public struct CatalystNullableStatusV1Wrapper: Decodable, Sendable {
  public let status: CatalystStatus?
}
