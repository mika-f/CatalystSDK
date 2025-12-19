// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public enum CatalystEndpoint: Endpoint {
  case createAlbum(data: CatalystCreateAlbumRequest)
  case getAlbum(id: String, since: String?, until: String?)
  case editAlbum(id: String, data: CatalystEditAlbumRequest)
  case insertToAlbum(id: String, data: CatalystInsertToAlbumRequest)
  case removeFromAlbum(id: String, data: CatalystRemoveFromAlbumRequest)
  case deleteAlbum(id: String)
  case listAlbums(username: String, includeSmartAlbums: Bool?)
  case searchAlbum(q: String, includeSmartAlbums: Bool?)
  case customReactions
  case relationships(id: String)
  case follow(data: CatalystRelationshipRequest)
  case remove(data: CatalystRelationshipRequest)
  case createSmartAlbum(data: CatalystCreateSmartAlbumRequest)
  case getSmartAlbum(id: String, since: String?, until: String?)
  case editSmartAlbum(id: String, data: CatalystEditSmartAlbumRequest)
  case deleteSmartAlbum(id: String)
  case searchSmartAlbum(q: String)
  case createStatus(data: CatalystCreateStatusRequest)
  case getStatus(id: String)
  case editStatus(id: String, data: CatalystEditStatusRequest)
  case deleteStatus(id: String)
  case isFavorited(id: String)
  case favorite(id: String)
  case unfavorite(id: String)
  case reactions(id: String)
  case react(id: String, symbol: String)
  case unreact(id: String, symbol: String)
  case contestTimeline(slug: String, since: String?, until: String?)
  case favoriteTimeline(since: String?, until: String?)
  case firehoseTimeline(since: String?, until: String?)
  case galleryTimeline(since: String?, until: String?)
  case homeTimeline(since: String?, until: String?)
  case searchTimeline(q: String?, exact: Bool?, since: String?, until: String?)
  case userTimeline(
    username: String, trimUser: Bool?, excludeSensitive: Bool?, since: String?, until: String?)
  case userGalleryTimeline(username: String, since: String?, until: String?)
  case trend

  public var path: String {
    switch self {
    case .createAlbum(_):
      return "/catalyst/v1/album"

    case .getAlbum(let id, _, _), .editAlbum(let id, _), .insertToAlbum(let id, _),
      .removeFromAlbum(let id, _), .deleteAlbum(let id):
      return "/catalyst/v1/album/by/id/\(id)"

    case .listAlbums(let username, _):
      return "/catalyst/v1/album/by/user/\(username)"

    case .searchAlbum(_, _):
      return "/catalyst/v1/album/search"

    case .customReactions:
      return "/catalyst/v1/reactions"

    case .relationships(let id):
      return "/catalyst/v1/album/relationships/\(id)"

    case .follow(_), .remove(_):
      return "/catalyst/v1/album/relationships"

    case .createSmartAlbum(_):
      return "/catalyst/v1/smart-album"

    case .getSmartAlbum(let id, _, _), .editSmartAlbum(let id, _), .deleteSmartAlbum(let id):
      return "/catalyst/v1/smart-album/\(id)"

    case .searchSmartAlbum(_):
      return "/catalyst/v1/smart-album/search"

    case .createStatus(_):
      return "/catalyst/v1/status"

    case .getStatus(let id):
      return "/catalyst/v1.1/status/\(id)"

    case .editStatus(let id, _), .deleteStatus(let id):
      return "/catalyst/v1/status/\(id)"

    case .isFavorited(let id), .favorite(let id), .unfavorite(let id):
      return "/catalyst/v1/status/\(id)/favorite"

    case .reactions(let id):
      return "/catalyst/v1/status/\(id)/reactions"

    case .react(let id, let symbol), .unreact(let id, let symbol):
      return "/catalyst/v1/status/\(id)/reactions/\(symbol)"

    case .contestTimeline(let slug, _, _):
      return "/catalyst/v1/timeline/contest/by/slug/\(slug)"

    case .favoriteTimeline(_, _):
      return "/catalyst/v1/timeline/favorite"

    case .firehoseTimeline(_, _):
      return "/catalyst/v1.1/timeline/firehose"

    case .galleryTimeline(_, _):
      return "/catalyst/v1/timeline/gallery"

    case .homeTimeline(_, _):
      return "/catalyst/v1.1/timeline/home"

    case .searchTimeline(_, _, _, _):
      return "/catalyst/v1/timeline/search"

    case .userTimeline(let username, _, _, _, _):
      return "/catalyst/v1/timeline/user/by/username/\(username)"

    case .userGalleryTimeline(let username, _, _):
      return "/catalyst/v1/timeline/user/by/username/\(username)/gallery"

    case .trend:
      return "/catalyst/v1/trend"
    }
  }

  public var method: HTTPMethod {
    switch self {
    case .getAlbum(_, _, _),
      .listAlbums(_, _),
      .searchAlbum(_, _),
      .customReactions,
      .relationships(_),
      .getSmartAlbum(_, _, _),
      .searchSmartAlbum(_),
      .getStatus(_),
      .isFavorited(_),
      .reactions(_),
      .contestTimeline(_, _, _),
      .favoriteTimeline(_, _),
      .firehoseTimeline(_, _),
      .galleryTimeline(_, _),
      .homeTimeline(_, _),
      .searchTimeline(_, _, _, _),
      .userTimeline(_, _, _, _, _),
      .userGalleryTimeline(_, _, _),
      .trend:
      return .get

    case .createAlbum(_),
      .follow(_),
      .createSmartAlbum(_),
      .createStatus(_),
      .favorite(_),
      .react(_, _):
      return .post

    case .editAlbum(_, _),
      .editSmartAlbum(_, _),
      .editStatus(_, _):
      return .patch

    case .insertToAlbum(_, _),
      .removeFromAlbum(_, _):
      return .put

    case .deleteAlbum(_),
      .remove(_),
      .deleteSmartAlbum(_),
      .deleteStatus(_),
      .unfavorite(_),
      .unreact(_, _):
      return .delete
    }
  }

  public var headers: [String: String]? {
    switch self {
    default:
      return nil
    }
  }

  public var queryParameters: [String: String]? {
    switch self {
    case .getAlbum(_, let since, let until),
      .getSmartAlbum(_, let since, let until),
      .contestTimeline(_, let since, let until),
      .favoriteTimeline(let since, let until),
      .firehoseTimeline(let since, let until),
      .galleryTimeline(let since, let until),
      .homeTimeline(let since, let until),
      .userGalleryTimeline(_, let since, let until):
      var params: [String: String] = [:]
      if let since {
        params["since"] = since
      }
      if let until {
        params["until"] = until
      }

      return params.isEmpty ? nil : params

    case .listAlbums(_, let includeSmartAlbums):
      return ["include_smart_albums": includeSmartAlbums.map { $0 ? "true" : "false" } ?? "false"]

    case .searchAlbum(let q, let includeSmartAlbums):
      return [
        "q": q,
        "include_smart_album": includeSmartAlbums.map { $0 ? "true" : "false" } ?? "false",
      ]

    case .searchSmartAlbum(let q):
      return ["q": q]

    case .searchTimeline(let q, let exact, let since, let until):
      var params: [String: String] = [:]
      if let q {
        params["q"] = q
      }
      if let exact {
        params["exact"] = exact ? "true" : "false"
      }
      if let since {
        params["since"] = since
      }
      if let until {
        params["until"] = until
      }

      return params.isEmpty ? nil : params

    case .userTimeline(_, let trimUser, let excludeSensitive, let since, let until):
      var params: [String: String] = [:]
      if let trimUser {
        params["trim_user"] = trimUser ? "true" : "false"
      }
      if let excludeSensitive {
        params["exclude_sensitive"] = excludeSensitive ? "true" : "false"
      }
      if let since {
        params["since"] = since
      }
      if let until {
        params["until"] = until
      }

      return params.isEmpty ? nil : params

    default:
      return nil
    }
  }

  public var body: Encodable? {
    switch self {
    case .createAlbum(let data):
      return data

    case .editAlbum(_, let data):
      return data

    case .insertToAlbum(_, let data):
      return data

    case .removeFromAlbum(_, let data):
      return data

    case .follow(let data), .remove(let data):
      return data

    case .createSmartAlbum(let data):
      return data

    case .editSmartAlbum(_, let data):
      return data

    case .createStatus(let data):
      return data

    case .editStatus(_, let data):
      return data

    default:
      return nil
    }
  }
}
