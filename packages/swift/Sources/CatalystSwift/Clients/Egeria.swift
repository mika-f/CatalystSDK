// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public final class Egeria: Sendable {
  private let client: CatalystSwift

  init(client: CatalystSwift) {
    self.client = client
  }

  public func me() async throws -> User {
    let wrapped: UserWrapped = try await client.get(endpoint: "/egeria/v1/me", parameters: [:])
    return wrapped.user
  }

  public func userByUsername(username: String) async throws -> User {
    let wrapped: UserWrapped = try await client.get(
      endpoint: "/egeria/v1/user/by/username/\(username)", parameters: [:])
    return wrapped.user
  }
}
