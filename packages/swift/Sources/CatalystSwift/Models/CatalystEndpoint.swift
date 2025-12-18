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

    case .getAlbum(let id, _, _):
    case .editAlbum(let id, _):
    case .insertToAlbum(let id, _):
    case .removeFromAlbum(let id, _):
    case .deleteAlbum(let id):
      return "/catalyst/v1/album/by/id/\(id)"

    case .listAlbums(let username, _):
      return "/catalyst/v1/album/by/user/\(username)"

    case .searchAlbum(_, _):
      return "/catalyst/v1/album/search"

    case .customReactions:
      return "/catalyst/v1/reactions"

    case .relationships(let id):
      return "/catalyst/v1/album/relationships/\(id)"

    case .follow(_):
    case .remove(_):
      return "/catalyst/v1/album/relationships"

    case .createSmartAlbum(_):
      return "/catalyst/v1/smart-album"

    case .getSmartAlbum(let id, _, _):
    case .editSmartAlbum(let id, _):
    case .deleteSmartAlbum(let id):
      return "/catalyst/v1/smart-album/\(id)"

    case .searchSmartAlbum(_):
      return "/catalyst/v1/smart-album/search"

    case .createStatus(_):
      return "/catalyst/v1/status"

    case .getStatus(let id):
      return "/catalyst/v1.1/status/\(id)"

    case .editStatus(let id, _):
    case .deleteStatus(let id):
      return "/catalyst/v1/status/\(id)"

    case .isFavorited(let id):
    case .favorite(let id):
    case .unfavorite(let id):
      return "/catalyst/v1/status/\(id)/favorite"

    case .reactions(let id):
      return "/catalyst/v1/status/\(id)/reactions"

    case .react(let id, let symbol):
    case .unreact(let id, let symbol):
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
    case .getAlbum(_, _, _):
    case .listAlbums(_, _):
    case .searchAlbum(_, _):
    case .customReactions:
    case .relationships(_):
    case .getSmartAlbum(_, _, _):
    case .searchSmartAlbum(_):
    case .getStatus(_):
    case .isFavorited(_):
    case .reactions(_):
    case .contestTimeline(_, _, _):
    case .favoriteTimeline(_, _):
    case .firehoseTimeline(_, _):
    case .galleryTimeline(_, _):
    case .homeTimeline(_, _):
    case .searchTimeline(_, _, _, _):
    case .userTimeline(_, _, _, _, _):
    case .userGalleryTimeline(_, _, _):
    case .trend:
      return .get

    case .createAlbum(_):
    case .follow(_):
    case .createSmartAlbum(_):
    case .createStatus(_):
    case .favorite(_):
    case .react(_, _):
      return .post

    case .editAlbum(_, _):
    case .editSmartAlbum(_, _):
    case .editStatus(_, _):
      return .patch

    case .insertToAlbum(_, _):
    case .removeFromAlbum(_, _):
      return .put

    case .deleteAlbum(_):
    case .remove(_):
    case .deleteSmartAlbum(_):
    case .deleteStatus(_):
    case .unfavorite(_):
    case .unreact(_, _):
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
    case .getAlbum(_, let since, let until):
    case .getSmartAlbum(_, let since, let until):
    case .contestTimeline(_, let since, let until):
    case .favoriteTimeline(let since, let until):
    case .firehoseTimeline(let since, let until):
    case .galleryTimeline(let since, let until):
    case .homeTimeline(let since, let until):
    case .userGalleryTimeline(_, let since, let until):
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

    case .follow(let data):
    case .remove(let data):
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
