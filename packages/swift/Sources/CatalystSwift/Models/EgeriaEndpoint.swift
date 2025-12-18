// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public enum EgeriaEndpoint: Endpoint {
  case me
  case update(data: EgeriaUpdateProfileRequest)
  case search(q: String)
  case user(id: String?, username: String?)

  public var path: String {
    switch self {
    case .me:
    case .update(_):
      return "/egeria/v1/me"

    case .search:
      return "/egeria/v1/search"

    case .user(let id, let username):
      if let id {
        return "/egeria/v1/user/by/id/\(id)"
      } else if let username {
        return "/egeria/v1/user/by/username/\(username)"
      } else {
        fatalError("Either id or username must be provided")
      }
    }
  }

  public var method: HTTPMethod {
    switch self {
    case .me:
    case .search(_):
    case .user(_, _):
      return .get

    case .update(_):
      return .patch
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
    case .search(let q):
      return [
        "q": q
      ]

    default:
      return nil
    }
  }

  public var body: (any Encodable)? {
    switch self {
    case .update(let data):
      return data

    default:
      return nil
    }
  }
}
