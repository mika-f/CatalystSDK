// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public struct NotificationAdditionalContext: Decodable, Sendable, Equatable, Hashable {
  public let type: String
  public let url: String
  public let format: String
}

public struct NotificationGroup: Decodable, Sendable, Equatable, Hashable {
  public let id: String
  public let body: String
  public let occurredBy: EgeriaUser
  public let isRead: Bool
  public let createdAt: String
  public let additionalContexts: NotificationAdditionalContext?
}
