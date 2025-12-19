// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

import Foundation

public struct CatalystStatus: Decodable, Sendable, Equatable, Hashable {
  public let id: String
  public let body: String
  public let user: EgeriaUser?
  public let medias: [Media]
  public let createdAt: Date
  public let updatedAt: Date
}

public struct CatalystStatusWrapper: Decodable, Sendable {
  public let status: CatalystStatus
}
