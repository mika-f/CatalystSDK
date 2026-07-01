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
