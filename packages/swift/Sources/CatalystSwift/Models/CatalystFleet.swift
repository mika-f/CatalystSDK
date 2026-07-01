// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

import Foundation

public struct CatalystFleetPlacement: Decodable, Sendable, Equatable, Hashable {
  public let posX: Double
  public let posY: Double
  public let scale: Double
  public let rotation: Double
}

public struct CatalystFleetText: Decodable, Sendable, Equatable, Hashable {
  public let id: String
  public let body: String
  public let textStyle: String
  public let textAlignment: String
  public let color: String
  public let backgroundColor: String?
  public let posX: Double
  public let posY: Double
  public let scale: Double
  public let rotation: Double
}

public struct CatalystFleetSticker: Decodable, Sendable, Equatable, Hashable {
  public let id: String
  public let emoji: String
  public let posX: Double
  public let posY: Double
  public let scale: Double
  public let rotation: Double
}

public struct CatalystFleetMedia: Decodable, Sendable, Equatable, Hashable {
  public let url: String
  public let alt: String
  public let width: Int?
  public let height: Int?
  public let placement: CatalystFleetPlacement?
}

public struct CatalystFleet: Decodable, Sendable, Equatable, Hashable {
  public let id: String
  public let backgroundColor: String
  public let renderedImageUrl: String?
  public let user: EgeriaUser
  public let texts: [CatalystFleetText]
  public let media: CatalystFleetMedia?
  public let stickers: [CatalystFleetSticker]
  public let reactions: [String: CatalystReaction]
  public let viewCount: Int
  public let createdAt: Date
  public let expiresAt: Date
}

public struct CatalystFleetViewer: Decodable, Sendable, Equatable, Hashable {
  public let user: EgeriaUser
  public let viewedAt: Date
}

public struct CatalystFleetRing: Decodable, Sendable, Equatable, Hashable {
  public let user: EgeriaUser
  public let hasUnread: Bool
  public let fleetCount: Int
}
