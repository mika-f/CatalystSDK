// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki
import Foundation

public final class SteambirdClient: Sendable {
  private let client: CatalystSwift

  public let ISSUER_CATALYST_SYSTEM_MESSAGE = "natsuneko-laboratory:catalyst"
  public let ISSUER_CATALYST_USER_MESSAGE = "natsuneko-laboratory:catalyst-message"
  public let ISSUER_EGERIA_SYSTEM_MESSAGE = "natsuneko-laboratory:egeria"

  init(client: CatalystSwift) {
    self.client = client
  }

  /// Gets notifications for a specific issuer, or all issuers if omitted.
  public func notifications(issuer: String? = nil, since: String? = nil, until: String? = nil)
    async throws -> [Notification]
  {
    let response: Notifications = try await client.request(
      SteambirdEndpoint.notifications(issuer: issuer, since: since, until: until))
    return response.notifications
  }

  /// Marks a notification as read.
  public func read(by id: String) async throws -> CatalystResult {
    return try await client.request(SteambirdEndpoint.read(id: id))
  }

  /// Marks all notifications as read.
  public func readAll(issuer: String? = nil) async throws -> CatalystResult {
    return try await client.request(SteambirdEndpoint.readAll(issuer: issuer))
  }

  /// Gets the unread notification count.
  public func unreads(issuer: String? = nil, issuers: [String] = []) async throws
    -> NotificationUnreadCount
  {
    return try await client.request(
      SteambirdEndpoint.unreads(issuer: issuer, issuers: issuers.isEmpty ? nil : issuers))
  }
}
