// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

import Foundation

public struct CatalystStatusVisitor: Decodable, Sendable, Equatable, Hashable {
  public let favorite: Bool
  public let reactions: [String]?
}

public struct CatalystStatusV1_1: Decodable, Sendable, Equatable, Hashable {
  public let id: String
  public let body: String
  public let user: EgeriaUser?
  public let medias: [Media]
  public let contest: CatalystStatusContest?
  public let reactions: [String: CatalystReaction]
  public let createdAt: Date
  public let updatedAt: Date
  public let visitor: CatalystStatusVisitor?
  public let privacy: CatalystStatusPrivacy
}

public struct CatalystStatusV1_1Wrapper: Decodable, Sendable {
  public let status: CatalystStatusV1_1
}
