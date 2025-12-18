// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public final class EgeriaClient: Sendable {
  private let client: CatalystSwift

  init(client: CatalystSwift) {
    self.client = client
  }
  
  public func me() async throws -> EgeriaUserWrapper? {
    return try await client.request(EgeriaEndpoint.me)
  }
  
  public func update(data: EgeriaUpdateProfileRequest) async throws {
    try await client.request(EgeriaEndpoint.update(data: data))
  }
  
  public func search(q: String) async throws -> EgeriaUsers {
    return try await client.request(EgeriaEndpoint.search(q: q))
  }
  
  public func user(by id: String? = nil, username: String? = nil) async throws -> EgeriaUserWrapper? {
    return try await client.request(EgeriaEndpoint.user(id: id, username: username))
  }
}
