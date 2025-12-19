// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public final class SteambirdClient: Sendable {
  private let client: CatalystSwift

  public let ISSUER_CATALYST_SYSTEM_MESSAGE = "natsuneko-laboratory:catalyst"
  public let ISSUER_CATALYST_USER_MESSAGE = "natsuneko-laboratory:catalyst-message"
  public let ISSUER_EGERIA_SYSTEM_MESSAGE = "natsuneko-laboratory:egeria"

  init(client: CatalystSwift) {
    self.client = client
  }

  public func notifications(issuer: String) async throws -> Notifications {
    return try await client.request(SteambirdEndpoint.notifications(issuer: issuer))
  }

  public func read(by id: String) async throws {
    try await client.request(SteambirdEndpoint.read(id: id))
  }

  public func readAll(issuer: String? = nil) async throws {
    try await client.request(SteambirdEndpoint.readAll(issuer: issuer))
  }

  public func unreads(issuers: [String] = []) async throws -> NotificationUnreadCount {
    return try await client.request(SteambirdEndpoint.unreads(issuers: issuers))
  }
}
