// Licensed under the MIT License
//
// Copyright (c) 2025 Natsune Mochizuki

public enum MediaEndpoint: Endpoint {
  case uploadV1
  // Not documented in the current OpenAPI spec, but still supported by the live API.
  case download(data: MediaDownloadRequest)
  case delete(data: MediaDeleteRequest)
  case upload

  public var path: String {
    switch self {
    case .uploadV1, .delete:
      return "/media/v1/upload"

    case .download:
      return "/media/v1/download"

    case .upload:
      return "/media/v2/upload"
    }
  }

  public var method: HTTPMethod {
    switch self {
    case .uploadV1, .upload, .download:
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
    case .download(let data):
      return data

    case .delete(let data):
      return data

    default:
      return nil
    }
  }
}
