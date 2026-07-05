// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

/// Client for Epiclese (World/Author metadata) API endpoints.
public final class EpicleseClient: Sendable {
  private let client: CatalystSwift

  init(client: CatalystSwift) {
    self.client = client
  }

  public func getAuthors(q: String? = nil, platform: String? = nil) async throws
    -> EpicleseAuthorsResult
  {
    return try await client.request(EpicleseEndpoint.getAuthors(q: q, platform: platform))
  }

  public func createAuthor(
    platformIdentifier: String, platform: String, name: String, id: String? = nil
  ) async throws -> EpicleseAuthor {
    let response: EpicleseAuthorWrapper = try await client.request(
      EpicleseEndpoint.createAuthor(
        data: EpicleseCreateAuthorRequest(
          id: id, platformIdentifier: platformIdentifier, platform: platform, name: name)))
    return response.author
  }

  public func getPlatforms() async throws -> [EpiclesePlatform] {
    let response: EpiclesePlatformsWrapper = try await client.request(EpicleseEndpoint.getPlatforms)
    return response.platforms
  }

  public func getPlatform(id: String) async throws -> EpiclesePlatform {
    let response: EpiclesePlatformWrapper = try await client.request(
      EpicleseEndpoint.getPlatform(id: id))
    return response.platform
  }

  public func getStatusMetadata(statusId: String) async throws -> [String: EpicleseStatusMetadataTag]
  {
    return try await client.request(EpicleseEndpoint.getStatusMetadata(statusId: statusId))
  }

  public func createStatusMetadata(
    statusId: String, tags: [EpicleseCreateStatusMetadataTagRequest]
  ) async throws -> [String: EpicleseStatusMetadataTag] {
    return try await client.request(
      EpicleseEndpoint.createStatusMetadata(statusId: statusId, data: tags))
  }

  public func getWorlds(q: String? = nil, platform: String? = nil, offset: Int? = nil) async throws
    -> [EpicleseWorld]
  {
    let response: EpicleseWorldsResult = try await client.request(
      EpicleseEndpoint.getWorlds(q: q, platform: platform, offset: offset))
    return response.items
  }

  public func createWorld(
    platformIdentifier: String, platform: String, name: String,
    author: EpicleseCreateWorldAuthorRequest? = nil, id: String? = nil
  ) async throws -> EpicleseWorld? {
    let response: EpicleseWorldWrapper = try await client.request(
      EpicleseEndpoint.createWorld(
        data: EpicleseCreateWorldRequest(
          id: id, platformIdentifier: platformIdentifier, platform: platform, name: name,
          author: author)))
    return response.world
  }

  public func resolveWorld(platform: String, name: String) async throws -> EpicleseWorld? {
    let response: EpicleseWorldWrapper = try await client.request(
      EpicleseEndpoint.resolveWorld(platform: platform, name: name))
    return response.world
  }
}
