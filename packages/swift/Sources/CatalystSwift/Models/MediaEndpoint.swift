// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public enum MediaEndpoint: Endpoint {
  case uploadV1
  case delete(data: MediaDeleteRequest)
  case upload

  public var path: String {
    switch self {
    case .uploadV1, .delete:
      return "/media/v1/upload"

    case .upload:
      return "/media/v2/upload"
    }
  }

  public var method: HTTPMethod {
    switch self {
    case .uploadV1, .upload:
      return .post

    case .delete:
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
    default:
      return nil
    }
  }

  public var body: (any Encodable)? {
    switch self {
    case .delete(let data):
      return data

    default:
      return nil
    }
  }
}
