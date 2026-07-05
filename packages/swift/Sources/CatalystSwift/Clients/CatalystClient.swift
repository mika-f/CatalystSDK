// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

import Foundation

public final class CatalystClient: Sendable {
  private let client: CatalystSwift

  init(client: CatalystSwift) {
    self.client = client
  }

  // MARK: - Album

  public func createAlbum(
    title: String, description: String? = nil, isPublic: Bool? = nil,
    mode: CatalystAlbumDisplayMode? = nil
  ) async throws -> Identity {
    return try await client.request(
      CatalystEndpoint.createAlbum(
        title: title, description: description, isPublic: isPublic, mode: mode))
  }

  public func getAlbum(id: String, limit: Int? = nil, since: String? = nil, until: String? = nil)
    async throws -> CatalystAlbum
  {
    return try await client.request(
      CatalystEndpoint.getAlbum(id: id, limit: limit, since: since, until: until))
  }

  public func insertToAlbum(id: String, statusId: String) async throws -> CatalystResult {
    return try await client.request(CatalystEndpoint.insertToAlbum(id: id, statusId: statusId))
  }

  public func removeFromAlbum(id: String, statusId: String) async throws -> CatalystResult {
    return try await client.request(CatalystEndpoint.removeFromAlbum(id: id, statusId: statusId))
  }

  public func editAlbum(
    id: String, title: String, description: String? = nil, isPublic: Bool? = nil,
    mode: CatalystAlbumDisplayMode? = nil
  ) async throws -> CatalystResult {
    return try await client.request(
      CatalystEndpoint.editAlbum(
        id: id,
        data: CatalystEditAlbumRequest(
          title: title, description: description, isPublic: isPublic, mode: mode)))
  }

  public func deleteAlbum(id: String) async throws -> CatalystResult {
    return try await client.request(CatalystEndpoint.deleteAlbum(id: id))
  }

  public func getAlbumBooks(id: String) async throws -> [CatalystAlbumBook] {
    return try await client.request(CatalystEndpoint.getAlbumBooks(id: id))
  }

  public func createAlbumBook(id: String, data: CatalystCreateAlbumBookRequest) async throws
    -> CatalystAlbumBook
  {
    return try await client.request(CatalystEndpoint.createAlbumBook(id: id, data: data))
  }

  public func getAlbumBook(id: String, bookId: String) async throws -> CatalystAlbumBook {
    return try await client.request(CatalystEndpoint.getAlbumBook(id: id, bookId: bookId))
  }

  public func regenerateAlbumBook(id: String, bookId: String) async throws -> CatalystAlbumBook {
    return try await client.request(CatalystEndpoint.regenerateAlbumBook(id: id, bookId: bookId))
  }

  public func getAlbumsByMe(includeSmartAlbums: Bool = false) async throws -> [CatalystSmartAlbum]
  {
    let response: CatalystSmartAlbums = try await client.request(
      CatalystEndpoint.getAlbumsByMe(includeSmartAlbums: includeSmartAlbums))
    return response.albums
  }

  public func listAlbums(by username: String, includeSmartAlbum: Bool = true) async throws
    -> [CatalystSmartAlbum]
  {
    let response: CatalystSmartAlbums = try await client.request(
      CatalystEndpoint.listAlbums(username: username, includeSmartAlbum: includeSmartAlbum))
    return response.albums
  }

  public func searchAlbums(q: String? = nil, includeSmartAlbum: Bool = true, until: String? = nil)
    async throws -> [CatalystSmartAlbum]
  {
    let response: CatalystSmartAlbums = try await client.request(
      CatalystEndpoint.searchAlbums(q: q, includeSmartAlbum: includeSmartAlbum, until: until))
    return response.albums
  }

  // MARK: - Announcements

  public func getAnnouncements() async throws -> [CatalystAnnouncement] {
    let response: CatalystAnnouncementsWrapper = try await client.request(
      CatalystEndpoint.getAnnouncements)
    return response.announcements
  }

  // MARK: - Blocks

  public func block(userId: String) async throws -> CatalystResult {
    return try await client.request(CatalystEndpoint.block(userId: userId))
  }

  public func unblock(userId: String) async throws -> CatalystResult {
    return try await client.request(CatalystEndpoint.unblock(userId: userId))
  }

  // MARK: - Contest
  // Note: the spec only exposes read + vote operations for contests; contest management
  // (create/edit/awards/collaborators/copy/dashboard/publish/polls) is no longer part of the API.

  public func getContestsByMe() async throws -> [CatalystContest] {
    let response: CatalystContestsWrapper = try await client.request(
      CatalystEndpoint.getContestsByMe)
    return response.contests
  }

  public func getContestBySlug(_ slug: String) async throws -> CatalystContest {
    let response: CatalystContestWrapper = try await client.request(
      CatalystEndpoint.getContestBySlug(slug: slug))
    return response.contest
  }

  public func getContestTimeline(slug: String) async throws -> [CatalystStatus] {
    let response: CatalystStatuses = try await client.request(
      CatalystEndpoint.getContestTimeline(slug: slug))
    return response.statuses
  }

  public func getContestVotes(slug: String) async throws -> CatalystUserVoteRights {
    return try await client.request(CatalystEndpoint.getContestVotes(slug: slug))
  }

  public func addContestVote(slug: String, status: String) async throws -> CatalystResult {
    return try await client.request(CatalystEndpoint.addContestVote(slug: slug, status: status))
  }

  public func removeContestVote(slug: String, status: String) async throws -> CatalystResult {
    return try await client.request(
      CatalystEndpoint.removeContestVote(slug: slug, status: status))
  }

  public func getContestsByUser(userId: String) async throws -> [CatalystContest] {
    let response: CatalystContestsWrapper = try await client.request(
      CatalystEndpoint.getContestsByUser(userId: userId))
    return response.contests
  }

  public func getCurrentContests() async throws -> [CatalystContest] {
    let response: CatalystContestsWrapper = try await client.request(
      CatalystEndpoint.getCurrentContests)
    return response.contests
  }

  public func searchContests(q: String? = nil, state: String? = nil, id: String? = nil)
    async throws -> [CatalystContest]
  {
    let response: CatalystContestsWrapper = try await client.request(
      CatalystEndpoint.searchContests(q: q, state: state, id: id))
    return response.contests
  }

  // MARK: - Custom reactions

  public func getCustomUserReactions() async throws -> CatalystCustomReactionList {
    return try await client.request(CatalystEndpoint.getCustomUserReactions)
  }

  public func createCustomReaction(
    shortcode: String,
    displayName: String,
    visibility: String = "public",
    imageData: Data,
    mimeType: String = "image/png"
  ) async throws -> CatalystUserCustomReaction {
    return try await client.requestMultipart(
      "/catalyst/v1/custom-reactions",
      fields: ["shortcode": shortcode, "displayName": displayName, "visibility": visibility],
      imageKey: "image",
      imageData: imageData,
      mimeType: mimeType
    )
  }

  public func updateCustomReaction(by id: String, data: CatalystUpdateCustomReactionRequest)
    async throws -> CatalystUserCustomReaction
  {
    return try await client.request(CatalystEndpoint.updateCustomReaction(id: id, data: data))
  }

  public func deleteCustomReaction(by id: String) async throws {
    try await client.request(CatalystEndpoint.deleteCustomReaction(id: id))
  }

  // MARK: - Fleet

  public func createFleet(data: CatalystCreateFleetRequest) async throws -> Identity {
    return try await client.request(CatalystEndpoint.createFleet(data: data))
  }

  public func getFleetByUsername(username: String) async throws -> [CatalystFleet] {
    return try await client.request(CatalystEndpoint.getFleetByUsername(username: username))
  }

  public func getFleets() async throws -> [CatalystFleetRing] {
    return try await client.request(CatalystEndpoint.getFleets)
  }

  public func getFleetById(id: String) async throws -> CatalystFleet {
    return try await client.request(CatalystEndpoint.getFleetById(id: id))
  }

  public func deleteFleet(id: String) async throws -> CatalystResult {
    return try await client.request(CatalystEndpoint.deleteFleet(id: id))
  }

  public func reactFleet(id: String, symbol: String) async throws -> CatalystReactionValue {
    return try await client.request(CatalystEndpoint.reactFleet(id: id, symbol: symbol))
  }

  public func unreactFleet(id: String, symbol: String) async throws -> CatalystReactionValue {
    return try await client.request(CatalystEndpoint.unreactFleet(id: id, symbol: symbol))
  }

  public func viewFleet(id: String) async throws -> CatalystResult {
    return try await client.request(CatalystEndpoint.viewFleet(id: id))
  }

  public func getFleetViewers(id: String) async throws -> [CatalystFleetViewer] {
    return try await client.request(CatalystEndpoint.getFleetViewers(id: id))
  }

  // MARK: - Privacy

  public func getPrivacySettings() async throws -> CatalystPrivacySettings {
    return try await client.request(CatalystEndpoint.getPrivacySettings)
  }

  public func updatePrivacySettings(followingListVisibility: String, followerListVisibility: String)
    async throws -> CatalystPrivacySettings
  {
    return try await client.request(
      CatalystEndpoint.updatePrivacySettings(
        data: CatalystPrivacySettings(
          followingListVisibility: followingListVisibility,
          followerListVisibility: followerListVisibility)))
  }

  // MARK: - Profile tags

  public func updateProfileTags(tags: [String]) async throws -> [CatalystProfileTag] {
    let response: CatalystProfileTagsWrapper = try await client.request(
      CatalystEndpoint.updateProfileTags(data: CatalystUpdateProfileTagsRequest(tags: tags)))
    return response.tags
  }

  public func getUsersByProfileTag(name: String, cursor: String? = nil) async throws
    -> CatalystProfileTagUsersResult
  {
    return try await client.request(
      CatalystEndpoint.getUsersByProfileTag(name: name, cursor: cursor))
  }

  public func getProfileTagsByUser(userId: String) async throws -> [CatalystProfileTag] {
    let response: CatalystProfileTagsWrapper = try await client.request(
      CatalystEndpoint.getProfileTagsByUser(userId: userId))
    return response.tags
  }

  public func getProfileTagSuggestions(q: String) async throws -> [CatalystProfileTagSuggestion] {
    let response: CatalystProfileTagSuggestionsWrapper = try await client.request(
      CatalystEndpoint.getProfileTagSuggestions(q: q))
    return response.tags
  }

  // MARK: - Random

  public func getRandomStatus() async throws -> CatalystStatus? {
    let response: CatalystNullableStatusV1Wrapper = try await client.request(
      CatalystEndpoint.getRandomStatus)
    return response.status
  }

  public func getRandomStatusV1_1() async throws -> CatalystStatusV1_1 {
    return try await client.request(CatalystEndpoint.getRandomStatusV1_1)
  }

  public func getOnThisDay() async throws -> CatalystStatusV1_1 {
    return try await client.request(CatalystEndpoint.getOnThisDay)
  }

  // MARK: - Reactions

  public func getOriginalReactions() async throws -> [CatalystCustomReaction] {
    return try await client.request(CatalystEndpoint.getOriginalReactions)
  }

  // MARK: - Relationships

  public func follow(userId: String) async throws -> CatalystResult {
    return try await client.request(CatalystEndpoint.follow(userId: userId))
  }

  public func remove(userId: String) async throws -> CatalystResult {
    return try await client.request(CatalystEndpoint.removeRelationship(userId: userId))
  }

  public func getRelationshipCounts(username: String) async throws -> CatalystRelationshipsCount {
    return try await client.request(CatalystEndpoint.getRelationshipCounts(username: username))
  }

  public func getFollowers(username: String, page: Int? = nil) async throws
    -> CatalystFollowingOrFollowersList
  {
    return try await client.request(CatalystEndpoint.getFollowers(username: username, page: page))
  }

  public func getFollowings(username: String, page: Int? = nil) async throws
    -> CatalystFollowingOrFollowersList
  {
    return try await client.request(
      CatalystEndpoint.getFollowings(username: username, page: page))
  }

  public func getRelationships(userId: String) async throws -> CatalystRelationships {
    return try await client.request(CatalystEndpoint.getRelationships(userId: userId))
  }

  // MARK: - Smart album

  public func createSmartAlbum(data: CatalystCreateSmartAlbumRequest) async throws -> Identity {
    return try await client.request(CatalystEndpoint.createSmartAlbum(data: data))
  }

  public func getSmartAlbum(
    id: String, limit: Int? = nil, since: String? = nil, until: String? = nil
  ) async throws -> CatalystSmartAlbum {
    return try await client.request(
      CatalystEndpoint.getSmartAlbum(id: id, limit: limit, since: since, until: until))
  }

  public func editSmartAlbum(id: String, data: CatalystEditSmartAlbumRequest) async throws
    -> CatalystSmartAlbum
  {
    return try await client.request(CatalystEndpoint.editSmartAlbum(id: id, data: data))
  }

  public func deleteSmartAlbum(id: String) async throws -> CatalystResult {
    return try await client.request(CatalystEndpoint.deleteSmartAlbum(id: id))
  }

  public func getSmartAlbumBooks(id: String) async throws -> [CatalystAlbumBook] {
    return try await client.request(CatalystEndpoint.getSmartAlbumBooks(id: id))
  }

  public func createSmartAlbumBook(id: String, data: CatalystCreateAlbumBookRequest) async throws
    -> CatalystAlbumBook
  {
    return try await client.request(CatalystEndpoint.createSmartAlbumBook(id: id, data: data))
  }

  public func getSmartAlbumBook(id: String, bookId: String) async throws -> CatalystAlbumBook {
    return try await client.request(CatalystEndpoint.getSmartAlbumBook(id: id, bookId: bookId))
  }

  public func regenerateSmartAlbumBook(id: String, bookId: String) async throws
    -> CatalystAlbumBook
  {
    return try await client.request(
      CatalystEndpoint.regenerateSmartAlbumBook(id: id, bookId: bookId))
  }

  public func getSmartAlbumsByUser(userId: String) async throws -> [CatalystSmartAlbum] {
    let response: CatalystSmartAlbums = try await client.request(
      CatalystEndpoint.getSmartAlbumsByUser(userId: userId))
    return response.albums
  }

  public func searchSmartAlbums(q: String? = nil) async throws -> [CatalystSmartAlbum] {
    let response: CatalystSmartAlbums = try await client.request(
      CatalystEndpoint.searchSmartAlbums(q: q))
    return response.albums
  }

  // MARK: - Status

  public func createStatus(data: CatalystCreateStatusRequest) async throws -> Identity {
    return try await client.request(CatalystEndpoint.createStatus(data: data))
  }

  public func getStatus(by id: String) async throws -> CatalystStatus {
    let response: CatalystStatusV1Wrapper = try await client.request(
      CatalystEndpoint.getStatus(id: id))
    return response.status
  }

  public func getStatusV1_1(by id: String) async throws -> CatalystStatusV1_1 {
    let response: CatalystStatusV1_1Wrapper = try await client.request(
      CatalystEndpoint.getStatusV1_1(id: id))
    return response.status
  }

  public func editStatus(by id: String, description: String) async throws -> Identity {
    return try await client.request(
      CatalystEndpoint.editStatus(id: id, data: CatalystEditStatusRequest(description: description)))
  }

  public func deleteStatus(by id: String) async throws -> CatalystMessage {
    return try await client.request(CatalystEndpoint.deleteStatus(id: id))
  }

  public func getAlbumsInStatus(by id: String) async throws -> [CatalystAlbum] {
    let response: CatalystAlbumsWrapper = try await client.request(
      CatalystEndpoint.getAlbumsInStatus(id: id))
    return response.albums
  }

  public func isFavorited(by id: String) async throws -> Bool {
    return try await client.request(CatalystEndpoint.isFavorited(id: id))
  }

  public func favorite(by id: String) async throws -> CatalystResult {
    return try await client.request(CatalystEndpoint.favorite(id: id))
  }

  public func unfavorite(by id: String) async throws -> CatalystResult {
    return try await client.request(CatalystEndpoint.unfavorite(id: id))
  }

  public func getReactions(by id: String) async throws -> [String: CatalystReaction] {
    let response: CatalystReactions = try await client.request(CatalystEndpoint.getReactions(id: id))
    return response.reactions
  }

  public func reactWithCustomReaction(by id: String, customReactionId: String) async throws {
    try await client.request(
      CatalystEndpoint.reactWithCustomReaction(id: id, customReactionId: customReactionId))
  }

  public func unreactWithCustomReaction(by id: String, customReactionId: String) async throws {
    try await client.request(
      CatalystEndpoint.unreactWithCustomReaction(id: id, customReactionId: customReactionId))
  }

  public func react(by id: String, symbol: String) async throws -> CatalystReactionValue {
    return try await client.request(CatalystEndpoint.react(id: id, symbol: symbol))
  }

  public func unreact(by id: String, symbol: String) async throws -> CatalystReactionValue {
    return try await client.request(CatalystEndpoint.unreact(id: id, symbol: symbol))
  }

  public func reportStatus(by id: String, reason: String, description: String? = nil) async throws
    -> Identity
  {
    return try await client.request(
      CatalystEndpoint.reportStatus(
        id: id, data: CatalystCreateReportRequest(reason: reason, description: description)))
  }

  // MARK: - Bulk status reactions

  public func getBulkStatusReactions(ids: [String]) async throws -> [String: [String: CatalystReaction]] {
    let response: CatalystBulkStatusReactions = try await client.request(
      CatalystEndpoint.getBulkStatusReactions(data: CatalystBulkStatusReactionsRequest(ids: ids)))
    return response.reactions
  }

  // MARK: - Timelines

  public func getArchiveTimeline(
    year: Int, month: Int, day: Int? = nil, since: String? = nil, until: String? = nil,
    userId: String? = nil, limit: Int? = nil, excludeSensitive: Bool? = nil
  ) async throws -> [CatalystStatus] {
    let response: CatalystStatuses = try await client.request(
      CatalystEndpoint.getArchiveTimeline(
        year: year, month: month, day: day, since: since, until: until, userId: userId,
        limit: limit, excludeSensitive: excludeSensitive))
    return response.statuses
  }

  public func getArchiveMonths() async throws -> [CatalystArchiveMonth] {
    let response: CatalystArchiveMonths = try await client.request(CatalystEndpoint.getArchiveMonths)
    return response.months
  }

  public func getTimelineByContestSlug(slug: String, since: String? = nil, until: String? = nil)
    async throws -> [CatalystStatus]
  {
    let response: CatalystStatuses = try await client.request(
      CatalystEndpoint.getTimelineByContestSlug(slug: slug, since: since, until: until))
    return response.statuses
  }

  public func getFavoriteTimeline(since: String? = nil, until: String? = nil) async throws
    -> [CatalystStatusV1_1]
  {
    let response: CatalystStatusesV1_1 = try await client.request(
      CatalystEndpoint.getFavoriteTimeline(since: since, until: until))
    return response.statuses
  }

  public func getFirehoseTimelineV1(since: String? = nil, until: String? = nil) async throws
    -> [CatalystStatus]
  {
    let response: CatalystStatuses = try await client.request(
      CatalystEndpoint.getFirehoseTimelineV1(since: since, until: until))
    return response.statuses
  }

  public func getGalleryTimeline(since: String? = nil, until: String? = nil) async throws
    -> [CatalystStatus]
  {
    let response: CatalystStatuses = try await client.request(
      CatalystEndpoint.getGalleryTimeline(since: since, until: until))
    return response.statuses
  }

  public func getHomeTimelineV1() async throws -> [CatalystStatus] {
    let response: CatalystStatuses = try await client.request(CatalystEndpoint.getHomeTimelineV1)
    return response.statuses
  }

  public func searchTimeline(
    q: String? = nil, exact: Bool? = nil, since: String? = nil, until: String? = nil
  ) async throws -> [CatalystStatus] {
    let response: CatalystStatuses = try await client.request(
      CatalystEndpoint.searchTimeline(q: q, exact: exact, since: since, until: until))
    return response.statuses
  }

  public func getUserTimeline(
    username: String, since: String? = nil, until: String? = nil, limit: Int? = nil,
    excludeSensitive: Bool? = nil
  ) async throws -> [CatalystStatus] {
    let response: CatalystStatuses = try await client.request(
      CatalystEndpoint.getUserTimeline(
        username: username, since: since, until: until, limit: limit,
        excludeSensitive: excludeSensitive))
    return response.statuses
  }

  public func getUserGalleryTimeline(username: String, since: String? = nil, until: String? = nil)
    async throws -> [CatalystStatus]
  {
    let response: CatalystStatuses = try await client.request(
      CatalystEndpoint.getUserGalleryTimeline(username: username, since: since, until: until))
    return response.statuses
  }

  public func getFirehoseTimeline(
    since: String? = nil, until: String? = nil, trimVisitor: Bool? = nil
  ) async throws -> [CatalystStatusV1_1] {
    return try await client.request(
      CatalystEndpoint.getFirehoseTimeline(since: since, until: until, trimVisitor: trimVisitor))
  }

  public func getHomeTimeline(
    since: String? = nil, until: String? = nil, trimVisitor: Bool? = nil
  ) async throws -> [CatalystStatusV1_1] {
    return try await client.request(
      CatalystEndpoint.getHomeTimeline(since: since, until: until, trimVisitor: trimVisitor))
  }

  // MARK: - Trend

  public func trend() async throws -> [String]? {
    return try await client.request(CatalystEndpoint.trend)
  }

  public func richTrend() async throws -> [CatalystRichTrendingItem]? {
    return try await client.request(CatalystEndpoint.richTrend)
  }
}
