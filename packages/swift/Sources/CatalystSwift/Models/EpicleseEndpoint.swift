// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public enum EpicleseEndpoint: Endpoint {
  case getAuthors(q: String?, platform: String?)
  case createAuthor(data: EpicleseCreateAuthorRequest)
  case getPlatforms
  case getPlatform(id: String)
  case getStatusMetadata(statusId: String)
  case createStatusMetadata(statusId: String, data: [EpicleseCreateStatusMetadataTagRequest])
  case getWorlds(q: String?, platform: String?, offset: Int?)
  case createWorld(data: EpicleseCreateWorldRequest)
  case resolveWorld(platform: String, name: String)

  public var path: String {
    switch self {
    case .getAuthors, .createAuthor:
      return "/epiclese/v1/authors"

    case .getPlatforms:
      return "/epiclese/v1/platforms"

    case .getPlatform(let id):
      return "/epiclese/v1/platforms/\(id)"

    case .getStatusMetadata(let statusId), .createStatusMetadata(let statusId, _):
      return "/epiclese/v1/tag/by/status/\(statusId)"

    case .getWorlds, .createWorld:
      return "/epiclese/v1/worlds"

    case .resolveWorld:
      return "/epiclese/v1/worlds/resolve"
    }
  }

  public var method: HTTPMethod {
    switch self {
    case .getAuthors, .getPlatforms, .getPlatform, .getStatusMetadata, .getWorlds, .resolveWorld:
      return .get

    case .createAuthor, .createStatusMetadata, .createWorld:
      return .post
    }
  }

  public var headers: [String: String]? {
    return nil
  }

  public var queryParameters: [String: String]? {
    switch self {
    case .getAuthors(let q, let platform):
      var params: [String: String] = [:]
      if let q { params["q"] = q }
      if let platform { params["platform"] = platform }
      return params.isEmpty ? nil : params

    case .getWorlds(let q, let platform, let offset):
      var params: [String: String] = [:]
      if let q { params["q"] = q }
      if let platform { params["platform"] = platform }
      if let offset { params["offset"] = String(offset) }
      return params.isEmpty ? nil : params

    case .resolveWorld(let platform, let name):
      return ["platform": platform, "name": name]

    default:
      return nil
    }
  }

  public var body: Encodable? {
    switch self {
    case .createAuthor(let data):
      return data

    case .createStatusMetadata(_, let data):
      return data

    case .createWorld(let data):
      return data

    default:
      return nil
    }
  }
}
