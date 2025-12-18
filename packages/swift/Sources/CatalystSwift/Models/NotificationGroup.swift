// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct NotificationGroup: Decodable, Sendable {
  public let id: String
  public let body: String
  public let occurredBy: EgeriaUser
  public let isRead: Bool
}
