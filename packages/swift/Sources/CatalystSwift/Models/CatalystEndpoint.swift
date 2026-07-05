// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public enum CatalystEndpoint: Endpoint {
  // Album
  case createAlbum(title: String, description: String?, isPublic: Bool?, mode: CatalystAlbumDisplayMode?)
  case getAlbum(id: String, limit: Int?, since: String?, until: String?)
  case insertToAlbum(id: String, statusId: String)
  case removeFromAlbum(id: String, statusId: String)
  case editAlbum(id: String, data: CatalystEditAlbumRequest)
  case deleteAlbum(id: String)
  case getAlbumBooks(id: String)
  case createAlbumBook(id: String, data: CatalystCreateAlbumBookRequest)
  case getAlbumBook(id: String, bookId: String)
  case regenerateAlbumBook(id: String, bookId: String)
  case getAlbumsByMe(includeSmartAlbums: Bool)
  case listAlbums(username: String, includeSmartAlbum: Bool)
  case searchAlbums(q: String?, includeSmartAlbum: Bool, until: String?)

  // Announcements
  case getAnnouncements

  // Blocks
  case block(userId: String)
  case unblock(userId: String)

  // Contest (read + vote only; management endpoints are no longer part of the spec)
  case getContestsByMe
  case getContestBySlug(slug: String)
  case getContestTimeline(slug: String)
  case getContestVotes(slug: String)
  case addContestVote(slug: String, status: String)
  case removeContestVote(slug: String, status: String)
  case getContestsByUser(userId: String)
  case getCurrentContests
  case searchContests(q: String?, state: String?, id: String?)

  // Custom reactions
  case getCustomUserReactions
  case updateCustomReaction(id: String, data: CatalystUpdateCustomReactionRequest)
  case deleteCustomReaction(id: String)

  // Fleet
  case createFleet(data: CatalystCreateFleetRequest)
  case getFleetByUsername(username: String)
  case getFleets
  case getFleetById(id: String)
  case deleteFleet(id: String)
  case reactFleet(id: String, symbol: String)
  case unreactFleet(id: String, symbol: String)
  case viewFleet(id: String)
  case getFleetViewers(id: String)

  // Privacy
  case getPrivacySettings
  case updatePrivacySettings(data: CatalystPrivacySettings)

  // Profile tags
  case updateProfileTags(data: CatalystUpdateProfileTagsRequest)
  case getUsersByProfileTag(name: String, cursor: String?)
  case getProfileTagsByUser(userId: String)
  case getProfileTagSuggestions(q: String)

  // Random
  case getRandomStatus
  case getRandomStatusV1_1
  case getOnThisDay

  // Reactions
  case getOriginalReactions

  // Relationships
  case follow(userId: String)
  case removeRelationship(userId: String)
  case getRelationshipCounts(username: String)
  case getFollowers(username: String, page: Int?)
  case getFollowings(username: String, page: Int?)
  case getRelationships(userId: String)

  // Smart album
  case createSmartAlbum(data: CatalystCreateSmartAlbumRequest)
  case getSmartAlbum(id: String, limit: Int?, since: String?, until: String?)
  case editSmartAlbum(id: String, data: CatalystEditSmartAlbumRequest)
  case deleteSmartAlbum(id: String)
  case getSmartAlbumBooks(id: String)
  case createSmartAlbumBook(id: String, data: CatalystCreateAlbumBookRequest)
  case getSmartAlbumBook(id: String, bookId: String)
  case regenerateSmartAlbumBook(id: String, bookId: String)
  case getSmartAlbumsByUser(userId: String)
  case searchSmartAlbums(q: String?)

  // Status
  case createStatus(data: CatalystCreateStatusRequest)
  case getStatus(id: String)
  case getStatusV1_1(id: String)
  case editStatus(id: String, data: CatalystEditStatusRequest)
  case deleteStatus(id: String)
  case getAlbumsInStatus(id: String)
  case isFavorited(id: String)
  case favorite(id: String)
  case unfavorite(id: String)
  case getReactions(id: String)
  case reactWithCustomReaction(id: String, customReactionId: String)
  case unreactWithCustomReaction(id: String, customReactionId: String)
  case react(id: String, symbol: String)
  case unreact(id: String, symbol: String)
  case reportStatus(id: String, data: CatalystCreateReportRequest)

  // Bulk status reactions
  case getBulkStatusReactions(data: CatalystBulkStatusReactionsRequest)

  // Timelines
  case getArchiveTimeline(
    year: Int, month: Int, day: Int?, since: String?, until: String?, userId: String?, limit: Int?,
    excludeSensitive: Bool?)
  case getArchiveMonths
  case getTimelineByContestSlug(slug: String, since: String?, until: String?)
  case getFavoriteTimeline(since: String?, until: String?)
  case getFirehoseTimelineV1(since: String?, until: String?)
  case getGalleryTimeline(since: String?, until: String?)
  case getHomeTimelineV1
  case searchTimeline(q: String?, exact: Bool?, since: String?, until: String?)
  case getUserTimeline(username: String, since: String?, until: String?, limit: Int?, excludeSensitive: Bool?)
  case getUserGalleryTimeline(username: String, since: String?, until: String?)
  case getFirehoseTimeline(since: String?, until: String?, trimVisitor: Bool?)
  case getHomeTimeline(since: String?, until: String?, trimVisitor: Bool?)

  // Trend
  case trend
  case richTrend

  public var path: String {
    switch self {
    case .createAlbum:
      return "/catalyst/v1/album"

    case .getAlbum(let id, _, _, _), .insertToAlbum(let id, _), .removeFromAlbum(let id, _),
      .editAlbum(let id, _), .deleteAlbum(let id):
      return "/catalyst/v1/album/by/id/\(id)"

    case .getAlbumBooks(let id), .createAlbumBook(let id, _):
      return "/catalyst/v1/album/by/id/\(id)/book"

    case .getAlbumBook(let id, let bookId):
      return "/catalyst/v1/album/by/id/\(id)/book/\(bookId)"

    case .regenerateAlbumBook(let id, let bookId):
      return "/catalyst/v1/album/by/id/\(id)/book/\(bookId)/regenerate"

    case .getAlbumsByMe:
      return "/catalyst/v1/album/by/me"

    case .listAlbums(let username, _):
      return "/catalyst/v1/album/by/user/\(username)"

    case .searchAlbums:
      return "/catalyst/v1/album/search"

    case .getAnnouncements:
      return "/catalyst/v1/announcements"

    case .block, .unblock:
      return "/catalyst/v1/blocks"

    case .getContestsByMe:
      return "/catalyst/v1/contest/by/me"

    case .getContestBySlug(let slug):
      return "/catalyst/v1/contest/by/slug/\(slug)"

    case .getContestTimeline(let slug):
      return "/catalyst/v1/contest/by/slug/\(slug)/timeline"

    case .getContestVotes(let slug):
      return "/catalyst/v1/contest/by/slug/\(slug)/vote"

    case .addContestVote(let slug, let status), .removeContestVote(let slug, let status):
      return "/catalyst/v1/contest/by/slug/\(slug)/vote/\(status)"

    case .getContestsByUser(let userId):
      return "/catalyst/v1/contest/by/user/\(userId)"

    case .getCurrentContests:
      return "/catalyst/v1/contest/current"

    case .searchContests:
      return "/catalyst/v1/contest/search"

    case .getCustomUserReactions:
      return "/catalyst/v1/custom-reactions"

    case .updateCustomReaction(let id, _), .deleteCustomReaction(let id):
      return "/catalyst/v1/custom-reactions/\(id)"

    case .createFleet:
      return "/catalyst/v1/fleet"

    case .getFleetByUsername(let username):
      return "/catalyst/v1/fleet/by/user/\(username)"

    case .getFleets:
      return "/catalyst/v1/fleet/ring"

    case .getFleetById(let id), .deleteFleet(let id):
      return "/catalyst/v1/fleet/\(id)"

    case .reactFleet(let id, let symbol), .unreactFleet(let id, let symbol):
      return "/catalyst/v1/fleet/\(id)/reactions/\(symbol)"

    case .viewFleet(let id):
      return "/catalyst/v1/fleet/\(id)/view"

    case .getFleetViewers(let id):
      return "/catalyst/v1/fleet/\(id)/viewers"

    case .getPrivacySettings, .updatePrivacySettings:
      return "/catalyst/v1/privacy/settings"

    case .updateProfileTags:
      return "/catalyst/v1/profile-tags"

    case .getUsersByProfileTag(let name, _):
      return "/catalyst/v1/profile-tags/by/name/\(name)/users"

    case .getProfileTagsByUser(let userId):
      return "/catalyst/v1/profile-tags/by/user/\(userId)"

    case .getProfileTagSuggestions:
      return "/catalyst/v1/profile-tags/suggestions"

    case .getRandomStatus:
      return "/catalyst/v1/random"

    case .getRandomStatusV1_1:
      return "/catalyst/v1.1/random"

    case .getOnThisDay:
      return "/catalyst/v1.1/on-this-day"

    case .getOriginalReactions:
      return "/catalyst/v1/reactions"

    case .follow, .removeRelationship:
      return "/catalyst/v1/relationships"

    case .getRelationshipCounts(let username):
      return "/catalyst/v1/relationships/by/username/\(username)/counts"

    case .getFollowers(let username, _):
      return "/catalyst/v1/relationships/by/username/\(username)/followers"

    case .getFollowings(let username, _):
      return "/catalyst/v1/relationships/by/username/\(username)/followings"

    case .getRelationships(let userId):
      return "/catalyst/v1/relationships/\(userId)"

    case .createSmartAlbum:
      return "/catalyst/v1/smart-album"

    case .getSmartAlbum(let id, _, _, _), .editSmartAlbum(let id, _), .deleteSmartAlbum(let id):
      return "/catalyst/v1/smart-album/by/id/\(id)"

    case .getSmartAlbumBooks(let id), .createSmartAlbumBook(let id, _):
      return "/catalyst/v1/smart-album/by/id/\(id)/book"

    case .getSmartAlbumBook(let id, let bookId):
      return "/catalyst/v1/smart-album/by/id/\(id)/book/\(bookId)"

    case .regenerateSmartAlbumBook(let id, let bookId):
      return "/catalyst/v1/smart-album/by/id/\(id)/book/\(bookId)/regenerate"

    case .getSmartAlbumsByUser(let userId):
      return "/catalyst/v1/smart-album/by/user/\(userId)"

    case .searchSmartAlbums:
      return "/catalyst/v1/smart-album/search"

    case .createStatus:
      return "/catalyst/v1/status"

    case .getStatus(let id), .editStatus(let id, _), .deleteStatus(let id):
      return "/catalyst/v1/status/\(id)"

    case .getStatusV1_1(let id):
      return "/catalyst/v1.1/status/\(id)"

    case .getAlbumsInStatus(let id):
      return "/catalyst/v1/status/\(id)/albums"

    case .isFavorited(let id), .favorite(let id), .unfavorite(let id):
      return "/catalyst/v1/status/\(id)/favorite"

    case .getReactions(let id):
      return "/catalyst/v1/status/\(id)/reactions"

    case .reactWithCustomReaction(let id, let customReactionId),
      .unreactWithCustomReaction(let id, let customReactionId):
      return "/catalyst/v1/status/\(id)/reactions/custom/\(customReactionId)"

    case .react(let id, let symbol), .unreact(let id, let symbol):
      return "/catalyst/v1/status/\(id)/reactions/\(symbol)"

    case .reportStatus(let id, _):
      return "/catalyst/v1/status/\(id)/report"

    case .getBulkStatusReactions:
      return "/catalyst/v1/statuses/reactions"

    case .getArchiveTimeline:
      return "/catalyst/v1/timeline/archive"

    case .getArchiveMonths:
      return "/catalyst/v1/timeline/archive/months"

    case .getTimelineByContestSlug(let slug, _, _):
      return "/catalyst/v1/timeline/contest/by/slug/\(slug)"

    case .getFavoriteTimeline:
      return "/catalyst/v1/timeline/favorite"

    case .getFirehoseTimelineV1:
      return "/catalyst/v1/timeline/firehose"

    case .getGalleryTimeline:
      return "/catalyst/v1/timeline/gallery"

    case .getHomeTimelineV1:
      return "/catalyst/v1/timeline/home"

    case .searchTimeline:
      return "/catalyst/v1/timeline/search"

    case .getUserTimeline(let username, _, _, _, _):
      return "/catalyst/v1/timeline/user/by/username/\(username)"

    case .getUserGalleryTimeline(let username, _, _):
      return "/catalyst/v1/timeline/user/by/username/\(username)/gallery"

    case .getFirehoseTimeline:
      return "/catalyst/v1.1/timeline/firehose"

    case .getHomeTimeline:
      return "/catalyst/v1.1/timeline/home"

    case .trend, .richTrend:
      return "/catalyst/v1/trend"
    }
  }

  public var method: HTTPMethod {
    switch self {
    case .getAlbum, .getAlbumBooks, .getAlbumBook, .getAlbumsByMe, .listAlbums, .searchAlbums,
      .getAnnouncements, .getContestsByMe, .getContestBySlug, .getContestTimeline,
      .getContestVotes, .getContestsByUser, .getCurrentContests, .searchContests,
      .getCustomUserReactions, .getFleetByUsername, .getFleets, .getFleetById, .getFleetViewers,
      .getPrivacySettings, .getUsersByProfileTag, .getProfileTagsByUser,
      .getProfileTagSuggestions, .getRandomStatus, .getRandomStatusV1_1, .getOnThisDay,
      .getOriginalReactions, .getRelationshipCounts, .getFollowers, .getFollowings,
      .getRelationships, .getSmartAlbum, .getSmartAlbumBooks, .getSmartAlbumBook,
      .getSmartAlbumsByUser, .searchSmartAlbums, .getStatus, .getStatusV1_1, .getAlbumsInStatus,
      .isFavorited, .getReactions, .getArchiveTimeline, .getArchiveMonths,
      .getTimelineByContestSlug, .getFavoriteTimeline, .getFirehoseTimelineV1, .getGalleryTimeline,
      .getHomeTimelineV1, .searchTimeline, .getUserTimeline, .getUserGalleryTimeline,
      .getFirehoseTimeline, .getHomeTimeline, .trend, .richTrend:
      return .get

    case .createAlbum, .createAlbumBook, .regenerateAlbumBook, .block, .addContestVote,
      .createFleet, .reactFleet, .viewFleet, .favorite, .reactWithCustomReaction, .react,
      .reportStatus, .getBulkStatusReactions, .follow, .createSmartAlbum, .createSmartAlbumBook,
      .regenerateSmartAlbumBook, .createStatus:
      return .post

    case .editAlbum, .updateCustomReaction, .updatePrivacySettings, .editSmartAlbum, .editStatus:
      return .patch

    case .insertToAlbum, .removeFromAlbum, .updateProfileTags:
      return .put

    case .deleteAlbum, .unblock, .removeContestVote, .deleteCustomReaction, .deleteFleet,
      .unreactFleet, .removeRelationship, .deleteSmartAlbum, .deleteStatus, .unfavorite,
      .unreactWithCustomReaction, .unreact:
      return .delete
    }
  }

  public var headers: [String: String]? {
    return nil
  }

  public var queryParameters: [String: String]? {
    switch self {
    case .getAlbum(_, let limit, let since, let until):
      var params: [String: String] = [:]
      if let limit { params["limit"] = String(limit) }
      if let since { params["since"] = since }
      if let until { params["until"] = until }
      return params.isEmpty ? nil : params

    case .getAlbumsByMe(let includeSmartAlbums):
      return ["include_smart_albums": includeSmartAlbums ? "true" : "false"]

    case .listAlbums(_, let includeSmartAlbum):
      return ["include_smart_album": includeSmartAlbum ? "true" : "false"]

    case .searchAlbums(let q, let includeSmartAlbum, let until):
      var params: [String: String] = ["include_smart_album": includeSmartAlbum ? "true" : "false"]
      if let q { params["q"] = q }
      if let until { params["until"] = until }
      return params

    case .searchContests(let q, let state, let id):
      var params: [String: String] = [:]
      if let q { params["q"] = q }
      if let state { params["state"] = state }
      if let id { params["id"] = id }
      return params.isEmpty ? nil : params

    case .getUsersByProfileTag(_, let cursor):
      var params: [String: String] = [:]
      if let cursor { params["cursor"] = cursor }
      return params.isEmpty ? nil : params

    case .getProfileTagSuggestions(let q):
      return ["q": q]

    case .getFollowers(_, let page):
      var params: [String: String] = [:]
      if let page { params["page"] = String(page) }
      return params.isEmpty ? nil : params

    case .getFollowings(_, let page):
      var params: [String: String] = [:]
      if let page { params["page"] = String(page) }
      return params.isEmpty ? nil : params

    case .getSmartAlbum(_, let limit, let since, let until):
      var params: [String: String] = [:]
      if let limit { params["limit"] = String(limit) }
      if let since { params["since"] = since }
      if let until { params["until"] = until }
      return params.isEmpty ? nil : params

    case .searchSmartAlbums(let q):
      var params: [String: String] = [:]
      if let q { params["q"] = q }
      return params.isEmpty ? nil : params

    case .getArchiveTimeline(
      let year, let month, let day, let since, let until, let userId, let limit,
      let excludeSensitive):
      var params: [String: String] = [
        "year": String(year),
        "month": String(month),
      ]
      if let day { params["day"] = String(day) }
      if let since { params["since"] = since }
      if let until { params["until"] = until }
      if let userId { params["userId"] = userId }
      if let limit { params["limit"] = String(limit) }
      if let excludeSensitive { params["excludeSensitive"] = excludeSensitive ? "true" : "false" }
      return params

    case .getTimelineByContestSlug(_, let since, let until):
      var params: [String: String] = [:]
      if let since { params["since"] = since }
      if let until { params["until"] = until }
      return params.isEmpty ? nil : params

    case .getFavoriteTimeline(let since, let until),
      .getFirehoseTimelineV1(let since, let until),
      .getGalleryTimeline(let since, let until):
      var params: [String: String] = [:]
      if let since { params["since"] = since }
      if let until { params["until"] = until }
      return params.isEmpty ? nil : params

    case .searchTimeline(let q, let exact, let since, let until):
      var params: [String: String] = [:]
      if let q { params["q"] = q }
      if let exact { params["exact"] = exact ? "true" : "false" }
      if let since { params["since"] = since }
      if let until { params["until"] = until }
      return params.isEmpty ? nil : params

    case .getUserTimeline(_, let since, let until, let limit, let excludeSensitive):
      var params: [String: String] = [:]
      if let since { params["since"] = since }
      if let until { params["until"] = until }
      if let limit { params["limit"] = String(limit) }
      if let excludeSensitive { params["exclude_sensitive"] = excludeSensitive ? "true" : "false" }
      return params.isEmpty ? nil : params

    case .getUserGalleryTimeline(_, let since, let until):
      var params: [String: String] = [:]
      if let since { params["since"] = since }
      if let until { params["until"] = until }
      return params.isEmpty ? nil : params

    case .getFirehoseTimeline(let since, let until, let trimVisitor),
      .getHomeTimeline(let since, let until, let trimVisitor):
      var params: [String: String] = [:]
      if let since { params["since"] = since }
      if let until { params["until"] = until }
      if let trimVisitor { params["trim_visitor"] = trimVisitor ? "true" : "false" }
      return params.isEmpty ? nil : params

    case .richTrend:
      return ["format": "rich"]

    default:
      return nil
    }
  }

  public var body: Encodable? {
    switch self {
    case .createAlbum(let title, let description, let isPublic, let mode):
      return CatalystCreateAlbumRequest(
        title: title, description: description, isPublic: isPublic, mode: mode)

    case .insertToAlbum(_, let statusId):
      return CatalystInsertToAlbumRequest(insert: statusId)

    case .removeFromAlbum(_, let statusId):
      return CatalystRemoveFromAlbumRequest(remove: statusId)

    case .editAlbum(_, let data):
      return data

    case .createAlbumBook(_, let data), .createSmartAlbumBook(_, let data):
      return data

    case .block(let userId), .unblock(let userId):
      return CatalystRelationshipRequest(userId: userId)

    case .updateCustomReaction(_, let data):
      return data

    case .createFleet(let data):
      return data

    case .updatePrivacySettings(let data):
      return data

    case .updateProfileTags(let data):
      return data

    case .follow(let userId), .removeRelationship(let userId):
      return CatalystRelationshipRequest(userId: userId)

    case .createSmartAlbum(let data):
      return data

    case .editSmartAlbum(_, let data):
      return data

    case .createStatus(let data):
      return data

    case .editStatus(_, let data):
      return data

    case .reportStatus(_, let data):
      return data

    case .getBulkStatusReactions(let data):
      return data

    default:
      return nil
    }
  }
}
