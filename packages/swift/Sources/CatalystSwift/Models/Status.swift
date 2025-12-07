// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

import Foundation

public struct Status: Codable, Equatable, Hashable, Identifiable, Sendable {
  public let id: String
  public let body: String
  public let createdAt: Date
  public let user: User
  public let medias: [Media]
}
