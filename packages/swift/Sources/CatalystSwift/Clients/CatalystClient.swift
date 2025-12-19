// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public final class CatalystClient: Sendable {
  private let client: CatalystSwift

  init(client: CatalystSwift) {
    self.client = client
  }

  public func createAlbum(data: CatalystCreateAlbumRequest) async throws -> Identity {
    return try await client.request(CatalystEndpoint.createAlbum(data: data))
  }

  public func getAlbum(by id: String, since: String? = nil, until: String? = nil) async throws
    -> CatalystAlbum
  {
    return try await client.request(CatalystEndpoint.getAlbum(id: id, since: since, until: until))
  }

  public func editAlbum(by id: String, data: CatalystEditAlbumRequest) async throws {
    try await client.request(CatalystEndpoint.editAlbum(id: id, data: data))
  }

  public func insertToAlbum(id: String, data: CatalystInsertToAlbumRequest) async throws {
    try await client.request(CatalystEndpoint.insertToAlbum(id: id, data: data))
  }

  public func removeFromAlbum(id: String, data: CatalystRemoveFromAlbumRequest) async throws {
    try await client.request(CatalystEndpoint.removeFromAlbum(id: id, data: data))
  }

  public func deleteAlbum(id: String) async throws {
    try await client.request(CatalystEndpoint.deleteAlbum(id: id))
  }

  public func listAlbums(by username: String, includeSmartAlbums: Bool = true) async throws
    -> CatalystSmartAlbums
  {
    return try await client.request(
      CatalystEndpoint.listAlbums(username: username, includeSmartAlbums: includeSmartAlbums))
  }

  public func searchAlbums(q: String, includeSmartAlbums: Bool = true) async throws
    -> CatalystSmartAlbums
  {
    return try await client.request(
      CatalystEndpoint.searchAlbum(q: q, includeSmartAlbums: includeSmartAlbums))
  }

  public func customReactions() async throws -> [CatalystCustomReaction] {
    return try await client.request(CatalystEndpoint.customReactions)
  }

  public func relationships(by id: String) async throws -> CatalystRelationships {
    return try await client.request(CatalystEndpoint.relationships(id: id))
  }

  public func follow(data: CatalystRelationshipRequest) async throws {
    try await client.request(CatalystEndpoint.follow(data: data))
  }

  public func remove(data: CatalystRelationshipRequest) async throws {
    try await client.request(CatalystEndpoint.remove(data: data))
  }

  public func createSmartAlbum(data: CatalystCreateSmartAlbumRequest) async throws -> Identity {
    return try await client.request(CatalystEndpoint.createSmartAlbum(data: data))
  }

  public func getSmartAlbum(by id: String, since: String?, until: String?) async throws
    -> CatalystSmartAlbum
  {
    return try await client.request(
      CatalystEndpoint.getSmartAlbum(id: id, since: since, until: until))
  }

  public func editSmartAlbum(by id: String, data: CatalystEditSmartAlbumRequest) async throws {
    try await client.request(CatalystEndpoint.editSmartAlbum(id: id, data: data))
  }

  public func deleteSmartAlbum(by id: String) async throws {
    try await client.request(CatalystEndpoint.deleteSmartAlbum(id: id))
  }

  public func searchSmartAlbum(q: String) async throws -> CatalystSmartAlbums {
    return try await client.request(CatalystEndpoint.searchSmartAlbum(q: q))
  }

  public func createStatus(data: CatalystCreateStatusRequest) async throws -> Identity {
    return try await client.request(CatalystEndpoint.createStatus(data: data))
  }

  public func getStatus(by id: String) async throws -> CatalystStatusWrapper {
    return try await client.request(CatalystEndpoint.getStatus(id: id))
  }

  public func editStatus(by id: String, data: CatalystEditStatusRequest) async throws {
    try await client.request(CatalystEndpoint.editStatus(id: id, data: data))
  }

  public func deleteStatus(by id: String) async throws {
    try await client.request(CatalystEndpoint.deleteStatus(id: id))
  }

  public func isFavorited(by id: String) async throws -> Bool {
    return try await client.request(CatalystEndpoint.isFavorited(id: id))
  }

  public func favorite(by id: String) async throws {
    try await client.request(CatalystEndpoint.favorite(id: id))
  }

  public func unfavorite(by id: String) async throws {
    try await client.request(CatalystEndpoint.unfavorite(id: id))
  }

  public func reactions(by id: String) async throws -> [String: CatalystReaction] {
    return try await client.request(CatalystEndpoint.reactions(id: id))
  }

  public func react(by id: String, symbol: String) async throws {
    try await client.request(CatalystEndpoint.react(id: id, symbol: symbol))
  }

  public func unreact(by id: String, symbol: String) async throws {
    try await client.request(CatalystEndpoint.unreact(id: id, symbol: symbol))
  }

  public func contestTimeline(by slug: String, since: String? = nil, until: String? = nil)
    async throws -> CatalystStatuses
  {
    return try await client.request(
      CatalystEndpoint.contestTimeline(slug: slug, since: since, until: until))
  }

  public func favoriteTimeline(since: String? = nil, until: String? = nil) async throws
    -> CatalystStatuses
  {
    return try await client.request(CatalystEndpoint.favoriteTimeline(since: since, until: until))
  }

  public func firehoseTimeline(since: String? = nil, until: String? = nil) async throws
    -> [CatalystStatus]
  {
    return try await client.request(CatalystEndpoint.firehoseTimeline(since: since, until: until))
  }

  public func galleryTimeline(since: String? = nil, until: String? = nil) async throws
    -> CatalystStatuses
  {
    return try await client.request(CatalystEndpoint.galleryTimeline(since: since, until: until))
  }

  public func homeTimeline(since: String? = nil, until: String? = nil) async throws
    -> [CatalystStatus]
  {
    return try await client.request(CatalystEndpoint.homeTimeline(since: since, until: until))
  }

  public func searchTimeline(
    q: String, exact: Bool = false, since: String? = nil, until: String? = nil
  ) async throws -> CatalystStatuses {
    return try await client.request(
      CatalystEndpoint.searchTimeline(q: q, exact: exact, since: since, until: until))
  }

  public func userTimeline(
    by username: String, trimUser: Bool? = false, excludeSensitive: Bool? = true,
    since: String? = nil, until: String? = nil
  ) async throws -> CatalystStatuses {
    return try await client.request(
      CatalystEndpoint.userTimeline(
        username: username, trimUser: trimUser, excludeSensitive: excludeSensitive, since: since,
        until: until))
  }

  public func userGalleryTimeline(by username: String, since: String? = nil, until: String? = nil)
    async throws -> CatalystStatuses
  {
    return try await client.request(
      CatalystEndpoint.userGalleryTimeline(username: username, since: since, until: until))
  }

  public func trend() async throws -> [String] {
    return try await client.request(CatalystEndpoint.trend)
  }
}
